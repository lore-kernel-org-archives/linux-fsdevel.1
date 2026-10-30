Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359929;
	b=DDfD021hs95O7hfdKnzNlCKpuJZAFejdDxZuHvfRtrblZC6g+t79KsXq4KJhBT69RSSE
	 hgPB5PIdxtayT+yP5WSdYrQNuv4YO1watSDNiRq4R75lYHgdrDzDX2ObeYtOB7OT0HK0/
	 0rqDG2jCKpyFhdgfMV1yfMdqIvISmW3QLp7BhRCMQpe33Zy3bN9lmjfSOZ6rf4VmB7xKv
	 Z0BwwzfkrXuASqkHP+WaNwNZUUFgCjgspE21IEjzKYUtqaPMA+8Ej4KmPavL1I6Gn47hr
	 0rqTpPtjORMcDtJni1AIDJb029TptxnDM4BngezxYOIB4OphJ7n7jRaxvyt5MG2p6gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w3FaApfnQUxZe5+ZRP29Y8HIAbXxDwnr+eEOtHj97Eo=;
	b=RDmdlIkaPLmJLLWDqBhNAvYaoYcuBX+Q3D/kAE5cqa6tTYHfTsDsy9Dm7phbj/JBunEy
	 4yn3BTSHyTApEGNyteZSJ118xQG1i+ICer4vEDQFcVW/NzMmol9owInpC+PpQ9yFsQAmO
	 HYPMPWE2pPqEyVK9oNuGx6PuQAGjZmSI17hRIV9j6hF7nyTKZ5x/QCAYDS6VwraKKG6K9
	 pecDSY6vsUG4F+nOg8VX+l5Fnw57S7eo9XkjFavu3tYy9+8RQFnm6JC1LN6BiEORc0oZc
	 GSHXNkcP1L0ZOcSjw+fAVdgtw+wx+tG+TczDGUjX43fMx+UPiBPmLk7jHn1kVp7WDhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUplMQnD;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD7606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 11:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BD7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUplMQnD
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so3400785e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359927; x=1793964727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3FaApfnQUxZe5+ZRP29Y8HIAbXxDwnr+eEOtHj97Eo=;
        b=SUplMQnDzEqeppg3hHhQFvs5OuRXjXuWed2i+5MTMjGwl/3gAaIW/U5/ZacB7PdaXd
         03t0KHi9CkOTNWMDvutW3nQG02sB363cOcP7gCGsvkcuJcTXYqy2uv9QWNkalaA3DNzs
         X7RGh2Iiey+zubRsGIOKz9+7wykxQnT6Jo34GgvXqz8qJQAplDexPdvRaEHnhHxLfwL3
         ATbRa4rbbaB/XcmYCLoHodnOvo8SS3zAAJ/nJmoPSs1vYcztUjmABPCrKeben+6BFtMr
         Gsddn6J/dR3hh32edF1RwvA6bUBAkppWDTSklMrWtLbR3pAk9D/xWvNP/iInwh27+2rq
         zvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359927; x=1793964727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3FaApfnQUxZe5+ZRP29Y8HIAbXxDwnr+eEOtHj97Eo=;
        b=bXR9MSGWHexXC3NKW96LriqdLdgLuXyC2F39UVQfV8OWzCQxO1PAbiM/CkRJNCwHCc
         DvSyjmf44HYCT1w/OTb/9y2ig1TiZkLZJb3TkATfEnnfw6mJeuO3V4Oywu6Hr//2xxUX
         8eYwValNc8ud1ltt1Y3PLC7dAMobqDTSQavgPh8H5+RasboQmjy0zppHCF5TTHHBWw7V
         j8CA5cPfK4Zb9y6ECzBFveTAN2UYei8jI5igsP97LN8Yr8cIMS3sWt8R4KdxvPufWErd
         ga1JOrpU8sCdyxyAezKATT18G89wB4t57Qfq7MBuvBSXC0rgK/uiNr576dlq4HP3bcBp
         QJXg==
X-Forwarded-Encrypted: i=1; AKwUvBwYN9/3BbskaGeWq/e2lQbyGKHWAdq6BPgnVIT50ZMqqAfBPB+9ybyAla8Cm5u+Bse6pnuMVJQD+QRfBIZV@vger.kernel.org
X-Gm-Message-State: AFq9FYJw9UAaoHJGqtqn0mah7hPPJdb9q4hH61VMOm1bXWT1QQkq0BQk
	jqnGxb3F0sck9ucn0wpl4uqgaSgzkA945yRNxn44nmQ+zf+vgR/4C0ro
X-Gm-Gg: AYBFou2DFm3l8pRfqiKcKAMpNUhUe2nUPN4RNhidKIMajkD9a2robHwoKg0YUctfP1F
	7KAUwrDAhdOOj4NPc1tBxaz1Np+U4gObyDyDMbt++PHJ2e2wpBvv0G6UKJjmk0YHxDV4Njixxh6
	GGv1988stjik45LKmSkHGN+NGoGVamSHN8qlRpRrPYRWFrmhsJ6uxe4Ne5GR++BBBkotlWySe6N
	pb3lJlDAaAeaYtMm5pMkcQQip1MCQOWx4b1sbygTXBlEoDzB3b5iWlvZ5w6xce2Wm2PNIVsoeYp
	vnk09YV1QQoX6ysPUoRcCEvgN+T/ZnXWpQBeZP3BpjHK37ydBPeOytQD1fa/B8tIXd8E06XSep9
	UcsNuzyAtYSvV1/3DeIqo5HxBgTFKgOqiTDEenTkg8+9bW0sWzZY2gSmGLn2eipMJ2gV0HwIhpk
	Pol2LQp2d8OvN5xZFIi9NhxV2iyhBLwopzxnduVzqlFJt/SHBfWOM89hfRR454Uvd+f3t8iyCSR
	Vj4r7yNu+8TQuMypNwumKHHxCC9S/ogaEBxAMkMWWCpO4ncyb8Bt6kLuohJ1w68j5VOuPPJY7b/
	3ss049lyd/B9rjqvFBA47ObW6GOvnZRG5JkPflYkFIKpfAyQ7XyK87Wmpl/m/E01im+F+H02Dj6
	TPZcDQRHGxITD7WHjb6XbPVKr16ZzD3X4Lw==
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ac19705d57mr40416405e9.31.1793359927376;
        Fri, 30 Oct 2026 04:32:07 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2640sm129004595e9.6.2026.10.30.04.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ovl: do not let chattr change the casefold flag
Date: Fri, 30 Oct 2026 12:32:00 +0100
Message-ID: <20261030113201.2921633-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030113201.2921633-1-amir73il@gmail.com>
References: <20261030113201.2921633-1-amir73il@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

chattr +F or -F on an overlay directory can make the directory, or the
whole mount, unusable. Lookups of the directory, and lookups in it, then
fail. From code inspection, the caller only needs to own the directory.
The upper filesystem must support casefolding: ext4 or f2fs with the
casefold feature, or tmpfs with the casefold option.

chattr +F and -F set and clear FS_CASEFOLD_FL, the casefold flag of a
directory. The flag enables casefolding (case-insensitive name lookup)
for the directory. All directories of an overlay must match the casefold
state that was recorded at mount time, and ovl_lookup_single() enforces
this:

- A lookup in a directory that does not match fails with -ESTALE.
- A lookup of the directory itself fails with -EREMOTE.

ovl_fileattr_set() copies the directory up, which creates it in the
upper layer if it only existed in a lower layer. It then passes
FS_CASEFOLD_FL on to the upper filesystem. The upper filesystem accepts
the change if the upper directory is empty, regardless of what the
merged directory contains. The merged directory is the one that the user
sees, with the names from the upper and the lower directories.

After the change the upper directory no longer matches the mount. If the
directory is the root of the overlay, the whole mount is affected.

The flag can also change without chattr +F or -F. chattr reads all flags
of a directory, changes one and writes all of them back. For a directory
that only exists in a lower layer, overlayfs reads the flags from the
lower filesystem. xfs with the ascii-ci feature reports FS_CASEFOLD_FL
on every inode, but never sets S_CASEFOLD, the inode flag that overlayfs
compares with the mount. So its directories count as not casefolded.
With a lower layer on such an xfs and an upper layer on ext4 with the
casefold feature, chattr +A on a lower-only directory therefore sets
FS_CASEFOLD_FL on the new, empty upper directory.

Reproduced as root on tmpfs and on ext4 with chattr +F or -F on an
overlay directory whose upper directory was empty. Afterwards lookups
below it failed with ESTALE, and lookups of the directory itself failed
with EREMOTE. The chattr +A case was seen once, on a kernel with an
earlier form of this patch that still passed the caller's flag on:
lookups of the directory failed with EREMOTE.

Fix this by returning -EOPNOTSUPP if FS_IOC_SETFLAGS, the only call that
can change the flag, asks for a casefold flag on a directory that does
not agree with the casefold state of the mount. This also refuses the
chattr +A case above.

Fixes: 083957f9614a ("ovl: support layers on case-folding capable filesystems")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: check the flag against the casefold state of the mount instead of
 reading back the flags]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7e1ac70c5d97b..e3aa0931bea9f 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -658,6 +658,14 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 	unsigned int flags;
 	int err;
 
+	/*
+	 * Lookup refuses a directory that does not agree with the casefold
+	 * state of the mount. Only FS_IOC_SETFLAGS can ask for a change.
+	 */
+	if (S_ISDIR(inode->i_mode) && fa->flags_valid &&
+	    !!(fa->flags & FS_CASEFOLD_FL) != OVL_FS(inode->i_sb)->casefold)
+		return -EOPNOTSUPP;
+
 	err = ovl_copy_up(dentry);
 	if (!err) {
 		ovl_path_real(dentry, &upperpath);
-- 
2.55.0

