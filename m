Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790383;
	b=caoTGEK4NC+PD4fDOdq3RAlnysECGy82tuxO07Sa6YoMUz4P0LfpGaKvkcV2OcRVm8cu
	 IJjC3nTDWi95I5xCUj7ubDqAj3qL2E/7xCt8uRCvOKmXdC8ebUMNWFQuLVvYMSD7jTlzT
	 j8UyzQEBfg4k6VnPW4UHNEo6PyH9Ltsi0vMwoanrrFuCBCSY9CXNqaKqWfRCieejTaBcF
	 bNtWgIZmMK4RwO+7mVANwbm6E0V/akq7zh88/0G7zPLT2LpJNhAwQtcoKPQBtnjhtzW7j
	 aNZqpWlUjPz9HMweXeWrMpKCVrSw5PpCHwIqJtQXCDfF0Gj7JXaSJbMB7COESDw6fGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ejFOU++T/9CCYj2HdH5u0LvKpWcRY11f5gk3oaVJvtY=;
	b=OTP+uCSm7KbLF26QLUoZ3yxcX/jCv2vb3YsULgTivzFNji4lMRPkSLmqKB+4Hs1ZDFPp
	 IzpgFKAepsLuy1HNFgjvvlQaVovKxiZSWcgf4xi9KXYDuCyJ5+drkfJcmz7mD2P8+re0s
	 6sAYcqeKCmLc0cY4GHc+rN2VAbkCtr11bpACqWhYmbEJEKO1i2VOX9dwVbAqgU2VSMVve
	 rPQ88wetJ/dajouRg7dcRf/lc95Y35Y+qaxORV4Ahc3BsyVIk5Lt5bFQhjm7WTTBj3prL
	 Pe8jGa2iCNvcAprOZ2xO4HCthVmqo5CP5ogXMwIIl+vdCwibdQyznjsiFl/1P4Hlsig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVcG1XGx;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC8606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99EC8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVcG1XGx
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso495402f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793790381; x=1794395181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejFOU++T/9CCYj2HdH5u0LvKpWcRY11f5gk3oaVJvtY=;
        b=FVcG1XGx2s+Hq6Xbx8OcBYgg40281bOLlyYaGn5g3/vhaALb2G3kbutwCtWtbvjxFe
         /PbfDtyTt4QhcW0vXqXdlZARJVL6PuwWH1GSOl0oQt+7mnvUA92HL7rzK11P0rVXy4uQ
         pSZ7I0QdFrLh67EBejhPG3MflzHLVBm86jx/hfcoTgmvyz4QTNNoA/NWn4hryKp7mZj/
         iR8EvGSPebjeW4oa4ZDfnLtKaLeoe0BBHGSl6Znf9Z8d1JTQXUQBTrhRZ6xljaO6eMqR
         xiPloGb1cv+I77BBfExpS9Bq2eYbt5KwUUZHRouM3NCx7/YvCx8tmBt5xEPF0uw2fcmZ
         fwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790381; x=1794395181;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejFOU++T/9CCYj2HdH5u0LvKpWcRY11f5gk3oaVJvtY=;
        b=tna2rHYHVFpYjYYcwMNuMbi1/NHKApzp/S88uOlbJJviUBeUFfVOckLHOBi5+ddh8i
         n9KTn9V2p7pv6aYJ+HMJNuZknCutVBlhu/iYLem5oum4lTRhv0dI7Q1Z4enMvjvYDZhW
         4sILTP06dHA28Tj8F5awgfchVznR0M1tIeXX+vCnq5O/hWCC+sNqNWIWkI+Uag5uYo+A
         qgDgZYdYam/bM4C1nENBu1GhDZxwr4pD6EiMCEw/cYsSKE4XXdldSyxuJPHIkY+3UyTY
         myV1Eh1xpPQ3rL1kXPW20PB9U0NR+YUtaOxgXLYYn4ZWCGXOpRGGSxdf2HWmG/ncbf8M
         UmVg==
X-Forwarded-Encrypted: i=1; AKwUvBx/laJy2V1oHRGNZkNyxJr6E40xkIT1u2GlWxQ39wbyZBbAc2Vipdw6OnIg/AD8xVYtVwr/LCtvGCgM4tOs@vger.kernel.org
X-Gm-Message-State: APuU4Z/uP6pJcAu52XRivrp178hYJlxvzYAKtNmWyDsaGkBtsHd+Fr9X
	FIb+xHt7FK058a/XqurApx+rWYPOatvzyp2Adenpe6BxiSQfROitIa/F
X-Gm-Gg: AYBFou07mhW0Oh00NYbD9zbFVoKmG6Srbz68pCXv/tEG4tN2jOyZFgEWbLvxIBYH4mc
	//mhc2EZLG7nzy79/jxq8QIl3FCzyKBYIFbBxIlDz1YbqNYxwNSFkcNIQ3q/mfe3WMzDuhoghNZ
	dh5vJlmhI7HTYO93QGcMI5R3bzlhItnBUfwma/uY/H6iO2JJV/2geJ3y0h2tN3FWLalpne/C1cX
	rkRgx099C9dk6+Fs/mmOMGJ9iERjXZC/Rss+Jxw5GrwfEme86LQ8wsQgEnGllnJEE85i7lYAyEv
	tLuwgBCR2bWpDFTMLINoni0yVQ2QC75JuysJmD5XgFyCK1tH2pEFAaAMpPmJQdHMlFVoubtY5Hf
	/bx0azr3T4LSsF61Nv9sOjad5yEU6VF2Ea35Yz/482+EE+XK4CBNeBPpreMkgwzbVYoQ6GUrh1+
	W4z9D3+3eFGhWCoKDkgsEbgEQj49RcZGtPc30APpjmDA9ITAdyVlDtvqcMzbSGyPh+7q37hBOGO
	3krk3Q5Gzyv0+T6TGiRQjBIFgyGfQhOSVXZ1KOXa7auBnfK5CdO8t1GqDocPXWpthxDEKAk0LRm
	elZ8EXWVURtzzzJkF23OSEKnTYMmlPiE0yuAAVXtzD3gbuE0eV7FjK9aDexdioqo/2mIYHvhw7W
	twvL7xjjSkoa8NCdqBCmWVJZu
X-Received: by 2002:a05:6000:2310:b0:490:a3e7:8af3 with SMTP id ffacd0b85a97d-490a3e78cd2mr650035f8f.35.1793790380848;
        Wed, 04 Nov 2026 03:06:20 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm3704835f8f.45.2026.11.04.03.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:06:20 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v2 1/3] fs: add filename_utimensat()
Date: Wed,  4 Nov 2026 12:06:02 +0100
Message-ID: <20261104110604.126717-2-meven29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104110604.126717-1-meven29@gmail.com>
References: <20261104110604.126717-1-meven29@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Méven Car <meven@kde.org>

Copy utilities that preserve timestamps, like cp -p or a file manager,
set the times of every copy after its last write. To do that through
io_uring, the request needs the utimensat() lookup on a name that was
imported at submission time.

io_uring takes the path of a request when it is submitted and looks it
up later, from a worker thread. The path ops it already has call the
filename_*() helpers of fs/namei.c with a struct filename. utimensat(2)
had no such helper: do_utimes_path() took the user pointer and imported
the name itself.

Split the lookup and the vfs_utimes() call out of do_utimes_path() into
filename_utimensat(), declared in fs/internal.h next to the other
filename_*() helpers. do_utimes_path() now only imports the name.

Signed-off-by: Méven Car <meven@kde.org>
---
 fs/internal.h |  2 ++
 fs/utimes.c   | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..985b2bc5895e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -63,6 +63,8 @@ int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int
 int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int filename_linkat(int olddfd, struct filename *old, int newdfd,
 			struct filename *new, int flags);
+int filename_utimensat(int dfd, struct filename *name,
+		       struct timespec64 *times, int flags);
 int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
diff --git a/fs/utimes.c b/fs/utimes.c
index e22664e4115f..8072f05ac8dc 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -79,8 +79,8 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 }
 EXPORT_SYMBOL_GPL(vfs_utimes);
 
-static int do_utimes_path(int dfd, const char __user *filename,
-		struct timespec64 *times, int flags)
+int filename_utimensat(int dfd, struct filename *name,
+		       struct timespec64 *times, int flags)
 {
 	struct path path;
 	int lookup_flags = 0, error;
@@ -91,7 +91,6 @@ static int do_utimes_path(int dfd, const char __user *filename,
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 
-	CLASS(filename_uflags, name)(filename, flags);
 retry:
 	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (error)
@@ -105,6 +104,13 @@ static int do_utimes_path(int dfd, const char __user *filename,
 	return error;
 }
 
+static int do_utimes_path(int dfd, const char __user *filename,
+		struct timespec64 *times, int flags)
+{
+	CLASS(filename_uflags, name)(filename, flags);
+	return filename_utimensat(dfd, name, times, flags);
+}
+
 static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 {
 	if (flags)
-- 
2.56.0

