Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201780;
	b=T9iA0iBRFPGL9EpTEoID1Haz0emAQlqw4lMTeaVpQh6+kAJ15r2ZT3MtRfPFaH37ywLF
	 AF66SsE7KgtwQL4wIqlWGSPBP2vew48WX9pKAgJ9QiXhD6pAnWe8mdjoQQuMe7oh5rPMy
	 zym/zfdtjGqaUKv2tZ9bjmlN2lXcw1cyLwbYDvQsCFSuTUldT+AxG+iXu2fanyjxo7wRz
	 y1YVvVx3hgiciRkSkf0ESNBnkMgB/R5Nndk2q5J9Rr19POLTx/8eqMht91/HM2RkvFvA3
	 TO+0BD/CNOwMMzRpCiUdi4pXneEx5zoIH5Zmw6bdTBWL3lDaOSHKmsJpwyAi0VoH2iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9Bz0lN3WwW56lrjEyeicNzFHRzWGZupLlnq02xtOwZE=;
	b=fQ4mpKBjfA+Uy32OzvSw4zeynD3w6973x55SAyMDtoKk4ITL1gDy8KayUV6nkkPhJArF
	 3hj/dVia27WD2Y7jaJt4Ttee90HoCxGdBhXm5qHMIajaUzU+8tCqqYWzTPta2AC37wCHr
	 bopGGdofu+WsnOtDQ0pDo0IR6nvo0FVHgWsBJ3D6FBCSY8okPi8lWN7xog6re9Z6NbsBJ
	 dL6BfS/y29JHw/fvp6f8nQKciY8m1JQ2PHBPE/kKbeXa4zoGU0xKBuiRPdRKhc6ImZivt
	 qkYm7B7Y5GIgJVU9SA+JyXQOR0aSPDE54udInt6UymEiu/5fh6QSr+isppPmzV8ykVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="o8+eS/kO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4460A2622
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E4460A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8+eS/kO
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso3449164a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201778; cv=none;
        d=google.com; s=arc-20260327;
        b=dnx44xyGEXS7XWji7uwb36gtVXKyHVZ23OWuVsztzwltjrjsl/hstHWmefajdTVN1a
         9+YsidcNsPEeolMaz6eFV1SixLRWZnmVeCvVXksyDoHytaF/q1Ft4UC7ZW43E6dplS3a
         fILuAvoKEwOX37AzpDUPgy8ht9wKgQKgw5P/0zANvQ6hyRs+nbgwHTOYKWcdmAzXYMXJ
         FgfpJWmbYyGfzHFvsxLFCxqGZyQzAbTE6/3FrtoDO//GGXv1vB+FCQ/hvUqhCmT1XkEv
         J7SHRBNxkhwLOe3jfQ8n/92de8k+AbuET3qNg1XfsbM3fBgvL0lwVjdMePEPD/vDgva+
         od3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Bz0lN3WwW56lrjEyeicNzFHRzWGZupLlnq02xtOwZE=;
        fh=hWQ3vu4kvHA5h9+99tGFShRbebbXj9YX4zQrOXzbyig=;
        b=YuhELgr4EN0jjHamlebnAg7iIv+N3xZbC8nFeRtYnuHIQL5ctF+MhJq3rG1KSERp9N
         7+3309qUzRS5WReSXB1kcupUpzvN2oXNAYj1LX013VJna6yK8Mw+NTA4axy5GTztiP+8
         LWOP0KVi6CfYBMG6ztGstB4c1mV8OxWKifBBjxP0ENW15TkWhgTAGlNSnBY5v1hKq0PT
         VG5wXa8XkZKbnTos7loIBtGwBqWFIBb1djZ32JT06wlUTswCbNaK9MCJv8FKcwfRxsJu
         fZ087D0xSYuXtv/Z3VZjfxsnWGhmu1Xy+Oo/zTmw31CbfY+u3XaYRbddlkoYtBQ0sjIg
         6PVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201778; x=1793806578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Bz0lN3WwW56lrjEyeicNzFHRzWGZupLlnq02xtOwZE=;
        b=o8+eS/kOJnmSQQuDmyzKcnpM8XIf62WHDcQTpfgGgAc33ST6Cpvb/Avm5gCEO3G83f
         mwT5WJaRXBMVxl81EO5AaJjNxHST8plT8azYXYCCF/zkFLzRRxL39DAnbyDEtc0izQ7z
         BXoAb+hBgpOG2MczfmPvBVDGk/iwK7R5wDwXpDgw00NJCrhcdpnLJlcQCfyX7fUAE/q3
         TuCIcIAJMA+UYbeKn4XOSAztm+6f2MAyPPJZPpKrZOIFxUTkZmyPclmqG21F1aEzhplB
         iTR/S6KCchmPfCqzmnzIC7zf+BT3HW7rmx33Rm1wtRiZPxIFwLBfca6G1MEP1JTTmXMW
         ehHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201778; x=1793806578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Bz0lN3WwW56lrjEyeicNzFHRzWGZupLlnq02xtOwZE=;
        b=TKBM113BbdS8XdyH03jUKRWOLNWYxgt/7QMBQgja++rRhC1hA7MeRacucRfs9OxBgj
         nuWcwVITrcRYJqPtED/rLF9bJ2qoZ4hZWNSpdAe56rH9UNBFpEdfsmhQnoxkY3bM13r4
         i8utDwlSsP5N+RHB46buNHjdE/FNCidFtv2um7DDzNLe7rkJMW2QvyNTemEgIlzbjXIf
         uQd1bscRB5TQNxIofHhJF4fZrc6fRgwTM4iGDuRzGFfzx4FdIDf/zvW13K99h34fFjN4
         gRwr9JKcSpBmv3piYSGSIHIPGUsdEeXipvF+kMTNeAxk11fjC4+WzCVS7Qa0UyUcVE2v
         itnA==
X-Forwarded-Encrypted: i=1; AKwUvBztVBmDr8+1/WeuKDHoovJyZTz3zhJUGLOCGxicsg6H5aqOEyf9vehe5szJGpHhW283lJsW9ZqpVoQglI7G@vger.kernel.org
X-Gm-Message-State: AFq9FYKFNOBMl1xz2l1QEK9szZjoHZY5cckt+pVf2m/wdpfLdf78VMvO
	bt+EJcKfuwxnzrAALVVQ6mGISFg10qWTo0uhRKFQxOedw4MVlPa0SbIF97dOm5kasJmpKiexoXJ
	s6x4ER9uuO8AeyE9DuJ9VQornVfuuFFY=
X-Gm-Gg: AYBFou2RIR4l7iNP1FA/CiobQ84mBkrIs5JWDLkl6xws0F9TzSv7MNLTcvRKdVjE/RE
	kCjcC1K/lEB5t6dA5pkDejccvmmz0YsQzSZYvk1/+1erPy0FHLooKW1uFPh2v1DOKJFZajBfqLW
	DkBNGBMA3MjYdIZD45httbmIC3WFN90q5Npbhp6tISwZD3wfF+AqyG1SsFma4NPixd8VTvGQenn
	0ay6y9k5daUxT8yllqe94G6HxVsjW6O68X3lBLZV6naxBaDGxdDJeZUaIAyS/iKwdGnljcfAfxh
	RKts6PXDZZ5BPj+3zEPz2hPr5yD91Hxiu5eudmte5ZsSpSsJE7siC0ozzhxpQ8Vf1ENQTUcCcbd
	8SIZPHeo+/e14iyDDSiWfm6mDReIw4/1uDVQQsuHjQT0xt4F+0fR/DG8D4Nw0VxpAwYpvAQ==
X-Received: by 2002:aa7:d955:0:b0:6b3:b0b2:6e7 with SMTP id
 4fb4d7f45d1cf-6b47bcde687mr3518808a12.18.1793201777944; Wed, 28 Oct 2026
 08:36:17 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
 <20261027-b4-ovl-containerized-sync-v1-1-802e512379a6@toxicpanda.com>
In-Reply-To: <20261027-b4-ovl-containerized-sync-v1-1-802e512379a6@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 17:36:06 +0200
X-Gm-Features: AclHuK-uy9OcEc2oh0_9o59ea-Px6xRmZClAxF9aj0taY8198qZo83-6yRUk1Js
Message-ID: <CAOQ4uxjNWagHSXM0q+3q-SwX1RRun746iSsfyoR-4fLjcqH16A@mail.gmail.com>
Subject: Re: [PATCH 01/10] fs: add SB_I_OVL_USE_SYNC_FS
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, 
	Carlos Maiolino <cem@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:09=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> sync_filesystem() writes every dirty inode of a filesystem and then calls
> ->sync_fs().  The data needs that.  Whether the metadata does depends on
> the filesystem.  ext2 copies an inode to its buffer in ->write_inode() an=
d
> nowhere else.  A filesystem which logs its metadata has recorded the
> change when it was made, and ->sync_fs() commits the log.
>
> overlayfs wants to sync what was changed through one overlay instead of
> the whole upper filesystem.  It knows which inodes it wrote data to.  It
> has a much harder time with all the inodes which the upper filesystem
> dirtied on its behalf, many of which it has no inode of its own for:
> whiteouts, index entries, work directories, the parents of all of them.
> With a filesystem which logs its metadata it doesn't have to know.
>
> Add SB_I_OVL_USE_SYNC_FS, by which a filesystem says that ->sync_fs() wit=
h
> wait set makes every change of metadata durable which was made before the
> call, whether ->write_inode() was called for the inode or not.  Timestamp=
s
> which lazytime holds back are not covered by that.  As an upper filesyste=
m
> of overlayfs it then gets ->sync_fs() instead of sync_filesystem().
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/fs/super_types.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_type=
s.h
> index 72f4288e16c5..370b0d27815b 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -359,5 +359,6 @@ struct super_block {
>  #define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this sup=
erblock */
>  #define SB_I_ALLOW_HSM 0x00004000      /* Allow HSM events on this super=
block */
>  #define SB_I_NO_DATA_INTEGRITY 0x00008000 /* fs cannot guarantee data pe=
rsistence on sync */
> +#define SB_I_OVL_USE_SYNC_FS   0x00010000 /* overlayfs: ->sync_fs() comm=
its all metadata */
>


I have some reservations about the flag name (how could I not).
Not easy, but can we try the flag to describe the contract?

I am interested to know if the same flag or maybe even a more
strict contract which is fulfilled by ext4/xfs/btrfs could be
used to help determine ovl_should_sync_metadata() -

In commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up")
we added fsync on parent directories and metadata after copy up
to fix correctness on ubifs.

In commit 1f6ee9be92f8d ("ovl: make fsync after metadata copy-up
opt-in mount option") fsync=3Dstrict was created for opting-in to fsync
parent dirs on copy up, after a report on regression over ext4 when
due to the unconditional metadata fsync.

I am wondering whether fsync=3Dauto could decide regarding fsync of
metadata on copy up depending on the flag, so metadata would be
fsynced on ubifs and not fsynced on ext4.

The problem is that your flag speaks of the metadata ordering contract
of sync_fs(sb) and my interest is the metadata ordering contract of
fsync(inode).

To be more specific, in this sequence:
mkdir t1
chmod 700 t1
mv t1 A
mkdir t2
chmod 700 t2
mv t2 A/B
touch t3
chmod 600 t3
sync -d t3
mv t3 A/B/foo

When A/B/foo is observed after a crash, in xfs I know that because
all metadata writes are serialized in the single transaction, the mode
of parents is correct.

Not sure about btrfs and ext4 fast commit.

If you think that the answer is that they provide the same guaranty
then if the flag could be named something like
SB_I_ORDERED_METADATA or something and
the contract is documented, then perhaps it also fits the
sync_fs case, because what you really want to know is that
sync_fs persistent the metadata that the inode depends on.

Am I talking nonsense?

Thanks,
Amir.
