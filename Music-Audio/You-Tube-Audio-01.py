#!/usr/bin/env python3
"""
YouTube Audio Downloader
Downloads YouTube videos in their best available audio format.
"""
import sys
from pathlib import Path

import yt_dlp


def download_youtube_audio(url, output_dir="downloads"):
    """
    Download a YouTube video's audio in the best available format.
    Args:
        url (str): YouTube video URL
        output_dir (str): Directory to save the audio file
    Returns:
        bool: True if successful, False otherwise
    """
    # Create output directory if it doesn't exist
    Path(output_dir).mkdir(exist_ok=True)
    # Configure yt-dlp options for audio only
    ydl_opts = {
        'format': 'bestaudio[ext=m4a]/bestaudio/best',
        'outtmpl': f'{output_dir}/%(title)s.%(ext)s',
        'keepvideo': False,
        # Skip unavailable videos
        'ignoreerrors': True,
        'skip_unavailable_fragments': True,
        'continue_dl': True,
        # Skip already downloaded files
        'download_archive': f'{output_dir}/.download_archive.txt',
        'no_overwrites': True,
    }
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            # Get video info first
            info = ydl.extract_info(url, download=False)
            title = info.get('title', 'Unknown')
            duration = info.get('duration', 0)
            print(f"Title: {title}")
            print(f"Duration: {duration // 60}:{duration % 60:02d}")
            print("Downloading audio...")
            # Download
            ydl.download([url])
            print(f"✅ Successfully downloaded: {title}")
            return True
    except Exception as e:
        print(f"❌ Error downloading video: {str(e)}")
        return False


def download_playlist(playlist_url, output_dir="downloads"):
    """
    Download all videos from a YouTube playlist as audio files.
    Args:
        playlist_url (str): YouTube playlist URL
        output_dir (str): Directory to save the audio files
    """
    Path(output_dir).mkdir(exist_ok=True)
    ydl_opts = {
        'format': 'bestaudio[ext=m4a]/bestaudio/best',
        'outtmpl': f'{output_dir}/%(playlist_index)02d - %(title)s.%(ext)s',
        'keepvideo': False,
        # Skip unavailable videos
        'ignoreerrors': True,
        'skip_unavailable_fragments': True,
        'extract_flat': False,
        'writeinfojson': False,
        # Continue on download errors
        'continue_dl': True,
        # Skip already downloaded files
        'download_archive': f'{output_dir}/.download_archive.txt',
        'no_overwrites': True,
    }
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            print("Downloading playlist...")
            # Get playlist info first to show progress
            try:
                playlist_info = ydl.extract_info(playlist_url, download=False)
                total_videos = len(playlist_info.get('entries', []))
                print(f"Found {total_videos} videos in playlist")
                print("Note: Private/unavailable videos will be skipped automatically")
                print("Note: Already downloaded videos will be skipped automatically")
            except Exception as e:
                print(f"Warning: Could not get playlist info: {e}")
            # Download with error handling
            ydl.download([playlist_url])
            print("✅ Playlist download completed!")
            print("Note: Any private/unavailable or already downloaded videos were automatically skipped")
    except Exception as e:
        if "Private video" in str(e) or "unavailable" in str(e).lower():
            print("⚠️  Some videos in the playlist are private or unavailable and were skipped")
            print("✅ All available videos have been downloaded successfully")
        else:
            print(f"❌ Error downloading playlist: {str(e)}")


def clear_download_history(output_dir="downloads"):
    """
    Clear the download history to re-download all files.
    Args:
        output_dir (str): Directory containing the download archive
    """
    archive_path = Path(output_dir) / ".download_archive.txt"
    if archive_path.exists():
        archive_path.unlink()
        print(f"✅ Download history cleared for {output_dir}")
        print("All videos will be re-downloaded on next run")
    else:
        print(f"No download history found in {output_dir}")


def show_download_history(output_dir="downloads"):
    """
    Show what has been downloaded previously.
    Args:
        output_dir (str): Directory containing the download archive
    """
    archive_path = Path(output_dir) / ".download_archive.txt"
    if archive_path.exists():
        with open(archive_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        print(f"📁 Download history for {output_dir}:")
        print(f"Total downloaded: {len(lines)} videos")
        if lines:
            print("Recent downloads:")
            for line in lines[-10:]:  # Show last 10
                video_id = line.strip().split()[-1] if line.strip() else "Unknown"
                print(f"  - Video ID: {video_id}")
    else:
        print(f"No download history found in {output_dir}")


def main():
    """Main function with interactive menu."""
    print("🎵 YouTube Audio Downloader")
    print("=" * 30)
    print("Note: Downloads audio in best available format (usually M4A/MP4)")
    # Check if required tools are available
    try:
        import yt_dlp
    except ImportError:
        print("❌ yt-dlp not found. Install it with: pip install yt-dlp")
        sys.exit(1)
    while True:
        print("\nOptions:")
        print("1. Download single video")
        print("2. Download playlist")
        print("3. Show download history")
        print("4. Clear download history")
        print("5. Exit")
        choice = input("\nEnter your choice (1-5): ").strip()
        if choice == "1":
            url = input("Enter YouTube video URL: ").strip()
            if not url:
                print("❌ Please enter a valid URL")
                continue
            output_dir = input("Enter output directory (default: downloads): ").strip() or "downloads"
            download_youtube_audio(url, output_dir)
        elif choice == "2":
            url = input("Enter YouTube playlist URL: ").strip()
            if not url:
                print("❌ Please enter a valid URL")
                continue
            output_dir = input("Enter output directory (default: downloads): ").strip() or "downloads"
            download_playlist(url, output_dir)
        elif choice == "3":
            output_dir = input("Enter directory to check (default: downloads): ").strip() or "downloads"
            show_download_history(output_dir)
        elif choice == "4":
            output_dir = input("Enter directory to clear history (default: downloads): ").strip() or "downloads"
            confirm = input(
                f"Are you sure you want to clear download history for '{output_dir}'? (y/N): ").strip().lower()
            if confirm == 'y':
                clear_download_history(output_dir)
            else:
                print("Operation cancelled")
        elif choice == "5":
            print("👋 Goodbye!")
            break
        else:
            print("❌ Invalid choice. Please try again.")
# Example usage as a script

if __name__ == "__main__":
    # You can also call functions directly:
    download_youtube_audio("https://www.youtube.com/watch?v=Gg6HIhQ9-cM")
    # main()
