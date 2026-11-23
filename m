Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795438859;
	b=CtU0W0bYevfuWbFL0maBEQQamh/2wylQeGAVE/XSYA2hVYMr7OYfKOo2xRsgOLeeWTdS
	 mvSUG+ki1rrsn9IXR5Cp5jzCxwdr2wgWq+LzZMMKN4uqu0EeYE5+RiwKwqBDVqm5zTbyr
	 wrRnacwk4CeQBsljds5A1jkkjcCA69590SSDfXiw5yX4BWXvYVJ6tKeDhOSOZqrScvXx0
	 a6LfpjFifos++Eh3r+bYZ6keQhWLuOeosaDl7Gjmm6NpN+hYvrjc6tcgVXtqxe9wLcukk
	 Yj9nH2VxsRTwdwu1NZYNrnjkSfr1QlMIHqXbydEStMdauLJteVA5EzCiSGYSxXHikPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AMCJ5wbvnIEodr6Bx3XwSyi7m8Nqsc1HfBhVMog/o3w=;
	b=OWPuOfPPvBCriGC61b9p1lq6bxBs0q2GvxLJjegF36CMLjdtyVLFrIY3IhVlaA7ahnSP
	 nfpzl13UJAm5UFeymnh7z9i67OJdDUQNEmyHxGSRKIFvp6Ae0oX5Blmf7Z4aFZEO06C68
	 uNDxX5DzqeEIbEpbb3kC5UMG0TyYLM6YbY811W0ur2PVEIF6FHIB6hqQpo9Rex/zi8ZaL
	 ASMY/cgc6sWQ6kNfftAlkCOU/tbZ96tYX0exsrfY6ydAKqq+YGhsxNi09kuOnJ1kdriiO
	 EzrM6ERUPCZ82Kh97KFssPR8r94BTfJOfU/OZvfzAFWqPT+9PBbgEZNMaQJvexk3v7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkson++k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1411606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 13:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1411606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkson++k
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so1399506a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 05:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795438857; cv=none;
        d=google.com; s=arc-20260327;
        b=sEhYCI+ler76EUl9GLY7Aa5yGQKXNlhHIJvXaNvii+lHtbp4Ndke4Xwix6f9Cy/21w
         jYNKgFfjmXuMbuLPFS4yBYWTLvrAimaN8CUUXVs7CMsWtv0HM7RDko21lQeGGR4Fsdms
         VbfYzsC8J4r2yj7arisf+WqZlyLtO9ESQMZrDST0s5AFLO1HkcC45Bc8nfjUGHDUBESw
         +Jw7kDshE6KeZlj0DlEXECjDOnuGngcHkCNQ/3LsqGhAcdAgBwDPsZG830A4y+qj+iOa
         tvtb7GNqQEQybIhhnTKa3fwo3S3RElI1+JRdJCq1fSAlpxwTQJ4sJV/VKQ8d8EDEjp8S
         M9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AMCJ5wbvnIEodr6Bx3XwSyi7m8Nqsc1HfBhVMog/o3w=;
        fh=o4u4E27SFPkSTxkx8k4hLoI9L09lrL6UNX1BFp7JsKc=;
        b=F+/4wLq1DfKwLfFpojdlx247X+dC8WoqWNiluvLVuiWKx8jKX5ZM/2W1O0LHYPe0Vd
         XDcQ+WpC/UFkGj6sukmx/LLYd8Dw6PdXexbzgcCjFHtdyQ0Rofn1JlCu/4wsWuwkfS0c
         AAMhwvAl3CTxAy2kFU9OOnE+4MhUALj5MFyB0xms/2iNnDpQeKhbo8EXUFLjRX9IlcCw
         bt2AhPMr2zQ3a22K1EKYqoX/eyYlM1H9wxC6U3ezgQYboxWRH8D+4VPkF1qRHU88EYUp
         QDi5p5p5xLtQyd92sAGneeVlI9yrOLPnQDTEvu0zviweuEIgWI7g0GnB5R0u3MC0JsUF
         7vsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438857; x=1796043657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMCJ5wbvnIEodr6Bx3XwSyi7m8Nqsc1HfBhVMog/o3w=;
        b=kkson++kiVuuq7GlVJEDUrQHu19KcH/nihH2BzgLa6gbrvy17AZmxY1D1w0dt2h46y
         /xXI9YCF3W8v6AnWEDT8Xid0rKVtto9xbQeFZkRGR+cb5Y8RIC0oMxupLBYaYJC4CQou
         6ZJgLzs7wocf6G/7L1QJdpNwS2lbDAistHwZiRuhKs46qZQI5UTzUa+r+vixCZl4Sxxv
         NpVQv5tq4rxjVYt/Ok4zCR0OsxODa6kreqGz8wEkn4nw5GUASkqE6hP4ExSDLRPowFf2
         0zimep72RFU7EbpYHdPGxIgrdpvUiN+7UnUUrPJ6dRIQHj227oDE5EmUxVXBkiebQasL
         M4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438857; x=1796043657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMCJ5wbvnIEodr6Bx3XwSyi7m8Nqsc1HfBhVMog/o3w=;
        b=nZi8JiFZtIMR3MrRAI2Evi55bee//rZZeBuZrmmy4/6y9t0MKJKMNgil4b7vKPIho3
         o/5NUPLrFpzdu718JuwUH1Skh5E0x/mse8nKO1QH+k0K02bHJN1h60KMHdMKovyvbR5N
         fQ6CeLcnnhvQUEi37i6WXAlu3AjsqV1I/44avJK0JG0HTD7nb7xVn8Ft2U9u25nZJmv5
         /8BKNrTDNp7TBgsPaYB4sCsVUEKyTc2iXkJyKs1l1qHw6Ri47MKHXIzgIqAU/afeCyNH
         TwFxrwGieo1jdq/GnUiHxFiDkfG8m42ujAzVNEU5UWrLsb5XxogGTJ1TLtUNCTd8LY9M
         LCOQ==
X-Forwarded-Encrypted: i=1; AL+hErHJ/SMIApdpUrzHKtEaB8xNy3P7m9+d6SVG7IUWMohExkyUixPwF0Aa/pqV1aWEVW0+XnxNubTJCYPJOpQt@vger.kernel.org
X-Gm-Message-State: APuU4Z9cUteYBB3AHc2sEcNpKT9Fs46UW6DEro+DRhaE6PqDIf6aX3pn
	IoGXUTMmN457Pvvxv+7Aj4rOYlVaBNdzlQTkd8VM0h5sXxPY40PAE1RIPeBHj0EIhknAbJP5wUd
	I1g16mQU6VBd3QVgoCMu7P8GyuPzETqc=
X-Gm-Gg: AZFdTZd8HD3D1p6BlylBX3d6Qd+A8/4oz08rklZZd9Hv0KeLDOrJik3nvDHzthApCBI
	/tvxqf243z8Xf/tTGFm/z27Jwdt+y1AM4qvVA5kqMqjX7QrOl8efqCFEkXPaR7mOmuxdS1SgLfL
	KNj7O46MbPfHdthNt0ccsHxCmeQ4vo/y8Za4+UK65yPPLTmeuiba4XGP4OQ2Vx0b4ATFxQ4Ehkc
	ya2PSvPaH6BGKEEwfepc4/vQW4A1CqUZYbOM6YchZWx4HD58DmzX2oGGlKrMjC0fEQGfitkS0aD
	xzegTq/WIqUvnAJt2P8eotRXS3paF9E2z9gEVE5y2XnNPUx6sgAo16KsVJZsLwe4PKCLc59O1FT
	W4WQziNRnr6jxKYvXPZPBFUM9SqZqTgM0ULhpiqfozuPUHh3ZcT1O5BNKxLDBGQI6mMZkWw==
X-Received: by 2002:a05:6402:501d:b0:6ba:659c:8ca3 with SMTP id
 4fb4d7f45d1cf-6ba659c8fb1mr5474446a12.10.1795438857096; Mon, 23 Nov 2026
 05:00:57 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122000856.536902-1-koray.fra@gmail.com> <20261122000856.536902-4-koray.fra@gmail.com>
In-Reply-To: <20261122000856.536902-4-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Nov 2026 14:00:44 +0100
X-Gm-Features: Aa3M54oIZEz33KQbWl8M_WOYBLraeDplxcWm8_8Bl8KeH9NFv_L8S3OGX6_s9I0
Message-ID: <CAOQ4uxgc6pP+_xvJMbqj6wOdGzS75Vn6x6i_vUfCJDD46DAA_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: switch to the new xflags fileattr API
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 1:09=E2=80=AFAM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Switch ntfs_fileattr_[gs]et() from the legacy FS_*_FL flags to the
> modern xflags (FS_XFLAG_*) fileattr API with masks.
>
> Introduce FS_XFLAG_COMPR and FS_XFLAG_ENCRYPT and add them to
> FS_XFLAG_COMMON (and add FS_COMPR_FL and FS_ENCRYPT_FL to FS_COMMON_FL)
> to be used in this API switch.
>
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
>  fs/file_attr.c           |  8 +++++
>  fs/ntfs/file.c           | 63 +++++++++++++++++++---------------------
>  include/linux/fileattr.h |  6 ++--
>  include/uapi/linux/fs.h  |  2 ++
>  4 files changed, 44 insertions(+), 35 deletions(-)
>
...

> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 50be49f4c913..fde6fb2fe39c 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -155,31 +155,37 @@ int ntfs_file_release(struct inode *vi, struct file=
 *filp)
>   * @dentry: dentry to report the flags of
>   * @fa: filled in with the flags of @dentry
>   */
> +#define NTFS_RO_XFLAGS (FS_XFLAG_COMPR | FS_XFLAG_ENCRYPT | FS_XFLAG_CAS=
EFOLD)
> +#define NTFS_RW_XFLAGS (FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
> +                       FS_XFLAG_NOATIME | FS_XFLAG_NODUMP)

Nit: checkpatch may allow 100 chars, but this due formatting is not
easy on the eyes
pls break to RO line and indent the broken lines below (


> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 4faa40febf11..219e7c8eb601 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -7,12 +7,14 @@
>  #define FS_COMMON_FL \
>         (FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
>          FS_NODUMP_FL | FS_NOATIME_FL | FS_DAX_FL | \
> -        FS_PROJINHERIT_FL | FS_VERITY_FL)
> +        FS_PROJINHERIT_FL | FS_VERITY_FL | FS_COMPR_FL | \
> +        FS_ENCRYPT_FL)
>
>  #define FS_XFLAG_COMMON \
>         (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
>          FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
> -        FS_XFLAG_PROJINHERIT | FS_XFLAG_VERITY)
> +        FS_XFLAG_PROJINHERIT | FS_XFLAG_VERITY | FS_XFLAG_COMPR | \
> +        FS_XFLAG_ENCRYPT)


Rule:

You cannot add a flag to common without carefully auditing all
filesystems that support the legacy flag.

FS_XFLAG_ENCRYPT can go into common but must also
go to FS_XFLAG_RDONLY_MASK because it's read-only for
all existing fs.

COMPR is rw for some fs and ro for others.
As with CASEFOLD, you cannot make it COMMON before
converting all casefold fs to new API so that each can say
whether it wants RO or RW.

I think there may be a way to deal with this easily since
ntfs doesn't need to set either but not sure.

>
>  /* Read-only inode flags */
>  #define FS_XFLAG_RDONLY_MASK \
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index e40806b3a69c..09fc7e066485 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -275,6 +275,8 @@ struct file_attr {
>  #define FS_XFLAG_CASENONPRESERVING 0x00080000  /* case not preserved */
>
>  #define FS_XFLAG_PROJID                0x00100000      /* project ID */
> +#define FS_XFLAG_COMPR         0x00200000      /* Compress file */
> +#define FS_XFLAG_ENCRYPT       0x00400000      /* Encrypted file */

This is a mistake of patch 1. the newline should remain above HASATTR
which is allocated from the end.


>  #define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   *=
/
>
>  /* the read-only stuff doesn't really belong here, but any other place i=
s

Thanks,
Amir.
>
