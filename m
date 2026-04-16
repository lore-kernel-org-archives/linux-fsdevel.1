Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51E7081F
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367509; cv=pass; b=IoIxkD7gXQZSIk0V5EnG7BajJeYekVRpGzdpmB5glkos61khwvoA5sgRhVHQ6iYGJqSmMKzVYpohO+z9zCynZOvsd+A9aSfHpme5QEAXpSWN4F43+naSKI4qFr474pMuZgsD+z1KK39Jd/2Vf0q6vIoz7ufX4uWy45eWtQ7pVHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367509; c=relaxed/simple;
	bh=YTWAuUgodP4x0SGZZNXpfJHoOQ/Al8dOyWsalMJbeKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyXUTV6SnpraFf45pGhgNWnqfyLXcpbLOT+VV1pM4EF6G6+p73dGBiV2wvkH6m3TnCKNHhdkERVwU6PYccJzi3U4vjQbG+ZkBWNm2CV+JvDBK5vEDO+5t3FenS2XDxjMmJqaEQ/YJZ3yjvBO5Cd9uex4lGV+sj9+ud1xC1xvURQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuvgudHs; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuvgudHs"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c755b2cdeso1366092466b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776367496; cv=none;
        d=google.com; s=arc-20240605;
        b=XZ69E0c4vZ03MEhYdfGlrUX30SUdIVdpN50DLWEhFYwO6hnHLxXfOBC2aa1jICmH1C
         NPH/Mn4HqPRwZY6OxWN1IKOpqUPRl6sQUQ84tbeKuDyQl8DblFbhxMpc4YQ9PjF6I9un
         zM9RnOJbWJGPo0jUrxVqb6Dw75iAFIGWmdoOR1mPYRfxSAZsnNtuRng7Vzqz2RqqJ3gz
         aInXHxYo9PatE/YqPUAD04GfW3QFZAac0Ve6sGEx+QI4WsuN3YXuCEgLH92CNSQxaF1V
         QLVWjNYT+rqk2fdRwSjIMpDlJeG30ZqeX5dJz/ehDTda2vFhWoG8J9SSfSDSrikk6PX6
         5aOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        fh=AgHdrEE3coPBm/MPzqbOrCwcrjro1YNs+aUyYm6KkfI=;
        b=EHuBbjlIZw7VBPgxkOZA4JIsRz5mzp/BOaUnCag9dxawvNiLl66Kj3Cj1XpqpsY5mn
         +x9Kcr0HrLKxS+q07PMWIfLjtt4Q0vr/L2nGu+tgSmFRS6V/QhRWp7nRpbSA+CErwth2
         EtwSSBVjqbZndI2Oj5bMUCT7XOrIe/5VXoGy+tPM06Anqc6kntMNbllc22yFSMuNmKrT
         AkCZDAdD3s/7e7JrNDHmlq2Nm+l2OZNYc7ZKEl+WXvqKGoAxI+vUaD2W4hkmo/SYBxzm
         Fnvc9MWhQSZvvTUlm67SOy/ejVpOafCflZAxg2g7lrrpgVnDz3upjQGg4BEZ2wuPrNay
         nAUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776367496; x=1776972296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        b=IuvgudHss3pf9xta9CoHzbNM/KkqwvVlbZG1ujAPlUvsEERquMRMCcNKuZB4ePTAM5
         7NtHkTfv5kJNgOXozHtBzx6BeOftPECAFzrLC/Kx+7C6Z+aMX16BAnXG4S26OUfk3WGg
         CWZQvHirIm8BMV/eAS7dQVd+snAopqjN+dWq8LBfZchgH0SFAJBxKZ7twV1lroXi7RqL
         6seCdSS2mS6a+aqyWvZotzTjBpSsVqzQV/ddt5/cyYwOEsyfwdY8ZTvZnZXvtx6xF+FO
         5LV2B5eGbqXEDNgAZKrrj0OIGOZ6Vfb9iUPXy8OI0AkX/Cx2xeQJhF/vFCWfKeI7U4O9
         g8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367496; x=1776972296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        b=fqYFje8+7FAKusoJedqIpotOwXvkS4OkELiWE5DWqDKSdrBuVrEa2a7pEA3dsnb1p8
         EPj9FusdqTBYK8K1CFjRKnYG3CMxK8GN35eMZoQz9fNvGqGw7LmxCXctnpLUvQQ3nFGR
         FzfuWpLR7OqSr+H1zk5aekOgn9sQvjCOs4M5GGWVrKFcEd9bzlb6ftbpdYeYdiLcG6s0
         v2Vj+OkvSJU6Slt46uysPOwNnC3kB2otsr1mDg4go7iD4IyVqt6VMuswncY32LIYJcsH
         xWFQIfuBzXJ6y6X/uYY7Zyz2rQitvEAJJHgJZtzUv+iYas+USEK9I7HM9dvRw5v8cK0S
         824A==
X-Forwarded-Encrypted: i=1; AFNElJ+7o96E9+sNOC5zD/i+Q4HgtyNHqT5BRxrJZWVNkM7KM9GGtvphP/OILlyBO+OZypVG99m0A3kmy08R92HX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9z7LcJ1peL0e8/swc5GUuy841AypNOh6BdhBVJv6nyh5XYLhd
	8/KXVNjYxbUi7mn0BD365Y9WVXdX8XoPXjgY3p5zxcHSy1He08ssbA5fZkufNrzZgAsKVaaqMVO
	7JNZj3nqtrvFEgDkqdsrsTB5z/Xm1zCM=
X-Gm-Gg: AeBDievEIfPTz1kygvEcB9xQezY8kUQ6CfYaERhq0Y+8/d8d0ND6OD0XUp7RccY9bot
	Zu0WY3noL6/wtlA1EO+g8UXvFilNrNo7XzwPBv7w8duPOVq1klW2HRQJA8h5ZTY4CVwhj0uaUXq
	8t3QbNUmWym1DZoD/WnXf+YTYtYkqa+CYRRO7J5Dgi1BySb3300ve01rcligko18MFxf5V6Og8A
	qMiOFNHyncXOIIuLuFh4RhsA0r6i/d68wH+zQhAP5tjJg2qEqoFEQXiKhzgqrLcajP1ce3XUCgK
	8/4glqweSLzi4YkRnc81OZIiBtSB3xqQqHe1O1e/GqvG9x+y8bPVee6fJBdSPJg=
X-Received: by 2002:a17:907:c002:b0:b9c:34f8:b969 with SMTP id
 a640c23a62f3a-ba3dd6a4727mr34562766b.49.1776367495571; Thu, 16 Apr 2026
 12:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org> <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Apr 2026 21:24:44 +0200
X-Gm-Features: AQROBzDkNbo1A8vs3cuxkYPYXRSUZziZymY7H6-6on9ynU_2C3mPiqqxTu3HE2k
Message-ID: <CAOQ4uxg2jHxCi77A1DGtopjZHsTNg4etdboW2GjL85N3uc_KqQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:35=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add a new fsnotify_rename_data struct and FSNOTIFY_EVENT_RENAME data
> type that carries both the moved dentry and the inode that was
> overwritten by the rename (if any).
>
> Update fsnotify_data_inode(), fsnotify_data_dentry(), and
> fsnotify_data_sb() to handle the new type, and add a new
> fsnotify_data_rename_target() helper for extracting the overwritten
> target inode.
>
> Update fsnotify_move() to use the new data type for FS_RENAME and
> FS_MOVED_TO events, passing the overwritten target inode through the
> event data. FS_MOVED_FROM is unchanged since the source directory
> doesn't need overwrite information.
>
> This is done so that fsnotify consumers like nfsd can atomically
> observe the overwritten file when a rename replaces an existing entry,
> without needing a separate FS_DELETE event.
>
> Assisted-by: Claude (Anthropic Claude Code)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fsnotify.h         |  8 ++++++--
>  include/linux/fsnotify_backend.h | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

It is strange to me that the NFS protocol needs to report the overwritten
node in the same event of the rename, but oh well, fine by me.

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 079c18bcdbde..bda798bc67bc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -257,6 +257,10 @@ static inline void fsnotify_move(struct inode *old_d=
ir, struct inode *new_dir,
>         __u32 new_dir_mask =3D FS_MOVED_TO;
>         __u32 rename_mask =3D FS_RENAME;
>         const struct qstr *new_name =3D &moved->d_name;
> +       struct fsnotify_rename_data rd =3D {
> +               .moved =3D moved,
> +               .target =3D target,
> +       };
>
>         if (isdir) {
>                 old_dir_mask |=3D FS_ISDIR;
> @@ -265,12 +269,12 @@ static inline void fsnotify_move(struct inode *old_=
dir, struct inode *new_dir,
>         }
>
>         /* Event with information about both old and new parent+name */
> -       fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
> +       fsnotify_name(rename_mask, &rd, FSNOTIFY_EVENT_RENAME,
>                       old_dir, old_name, 0);
>
>         fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
>                       old_dir, old_name, fs_cookie);
> -       fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
> +       fsnotify_name(new_dir_mask, &rd, FSNOTIFY_EVENT_RENAME,
>                       new_dir, new_name, fs_cookie);
>
>         if (target)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 66e185bd1b1b..f8c8fb7f34ae 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -311,6 +311,7 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_DENTRY,
>         FSNOTIFY_EVENT_MNT,
>         FSNOTIFY_EVENT_ERROR,
> +       FSNOTIFY_EVENT_RENAME,
>  };
>
>  struct fs_error_report {
> @@ -335,6 +336,11 @@ struct fsnotify_mnt {
>         u64 mnt_id;
>  };
>
> +struct fsnotify_rename_data {
> +       struct dentry *moved;   /* the dentry that was renamed */
> +       struct inode *target;   /* inode overwritten by rename, or NULL *=
/
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int da=
ta_type)
>  {
>         switch (data_type) {
> @@ -348,6 +354,8 @@ static inline struct inode *fsnotify_data_inode(const=
 void *data, int data_type)
>                 return d_inode(file_range_path(data)->dentry);
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *)data)->inode;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return d_inode(((const struct fsnotify_rename_data *)data=
)->moved);
>         default:
>                 return NULL;
>         }
> @@ -363,6 +371,8 @@ static inline struct dentry *fsnotify_data_dentry(con=
st void *data, int data_typ
>                 return ((const struct path *)data)->dentry;
>         case FSNOTIFY_EVENT_FILE_RANGE:
>                 return file_range_path(data)->dentry;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return ((struct fsnotify_rename_data *)data)->moved;
>         default:
>                 return NULL;
>         }
> @@ -395,6 +405,8 @@ static inline struct super_block *fsnotify_data_sb(co=
nst void *data,
>                 return file_range_path(data)->dentry->d_sb;
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *) data)->sb;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return ((const struct fsnotify_rename_data *)data)->moved=
->d_sb;
>         default:
>                 return NULL;
>         }
> @@ -430,6 +442,14 @@ static inline struct fs_error_report *fsnotify_data_=
error_report(
>         }
>  }
>
> +static inline struct inode *fsnotify_data_rename_target(const void *data=
,
> +                                                       int data_type)
> +{
> +       if (data_type =3D=3D FSNOTIFY_EVENT_RENAME)
> +               return ((const struct fsnotify_rename_data *)data)->targe=
t;
> +       return NULL;
> +}
> +
>  static inline const struct file_range *fsnotify_data_file_range(
>                                                         const void *data,
>                                                         int data_type)
>
> --
> 2.53.0
>
