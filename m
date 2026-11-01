Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793536484;
	b=VhsiC1rCIWOeqyoXB0ukjpwiRn4OCepZ/wUWqkdozV3cNrxZTarjSp735NFOHf9wnuQG
	 g/meUtLlZafSfZYReKMkdByIa286/hksK0E/1XB2wObMorfEMt6wAaOlwc7xddSY8QjQf
	 NZmGrDA2kGlbY1mwlpiZrxltOkEkZP8w/+lJP5FBylrnqqhSHwYt3OSkLy7/VCxQcRdny
	 gTKiMSIaC8Mt72qsBap2ICR8uVTG2KuwtH0Lkze9/HXKdeBqV1BjXlpg42f/UQsopMRs7
	 wyM0QNTsURqsh/g/ErBjHrsKWzgb1VEfYujAMS3l1jSKpZD62ciiJCMXOb9eCXw1ucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793536484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/D/A9T2EJRYZY/+rdAawlrNFx7uSdrcye6ffwoxRa54=;
	b=JL5zASBiX0I+DI6I581nKyfurznvOsGwlzo1dXb84xOlFnMKUhY5rrKXwB0yNDg8Z25T
	 Ez6tVzUtuT1XcpgRmrSy37S+DD8lK9jmGTG+GkWgZzbTfA0itDS8ogBTT7qLi2mqX3gkF
	 YdYgHy6nvR92maHfGNF0nMLLD7Iz4dtfP0flh8Pw/ClF1xEeSBkOwG6E/sHyY+uIOqrYA
	 oTg4HI7Zj6rgd7XfGJQb0FOUlxkOI20eMiVE62zwYYPNdXtlPfCbCNWXQlugh/mLMo+26
	 jHviwza0dKN+VPoOdyhZOyxd/TCsO763FWqCsskZYirofKY3IYEJqZeI2HV64lCzorQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ea5BdI1n;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E8606A325
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 12:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B7E8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ea5BdI1n
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40e30c26a4so639879266b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793536482; x=1794141282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/D/A9T2EJRYZY/+rdAawlrNFx7uSdrcye6ffwoxRa54=;
        b=ea5BdI1n3jMl3nTFIjg1OVwLozn1JI9ufbHSZXBBTwqcISfpOrOD/hWSMAK8goj+JV
         ghJw6j73yFnthUnjFxDslLRT+4HB7LlKV30AQYBDStO7smzuBRVrv8FErRmKnTSoG+Hj
         HGHO7IrLwKc0e5GRHgH76UfMvD0Kx9ImmbG7L6G4wlqp8coCHtDEUXPTDrPeq16C0EJk
         B4SjJ2hc8+jSM00jQEiKvveoTypIWvKmLgpreALDqigMx4jHf5g6oCgmucBsLR6y2anN
         cpWLspOjtXj3p1OjOQQA6moH5MO6dK1nAz8nb8lfgSH1fVyNMRdow7h2cIsuiO7KjvR6
         4LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793536482; x=1794141282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/D/A9T2EJRYZY/+rdAawlrNFx7uSdrcye6ffwoxRa54=;
        b=n3Hhx31fQBCiErIhNcKLcpuw3qmgaLr5D2D2wn4kW0EF3A0j+SzoddIcDOaTo9XhkD
         Kmw9pceDTDXzEDjkiFQmntfZbrDy4EZUN6AZaNtiLF0MD9sSy6LVBmdBXIO86TEloVwT
         0cAPOqmFNzpQeaj5F4kxSlCRNVT7K1KLeKwViQnWlf+YzM7h2gty/JPAOQQnpmxJARyB
         Xw96qeOx7MoVebh+w+b3lXw2ItqogKvmnQlFnhuQY8AYOla1yLHR+cM+E1y1BCTh69nz
         gbXlOz4AnNAw8zutD4zQOZuZPTmUdmppb+VjSw03JWO5hXeoovbrrs/pEtoEJSpA+fPQ
         Prhg==
X-Gm-Message-State: AFq9FYJxe34C8OYzneeHIP8BPW9plsugTzH2H9/jSAfphRDwLmarPiK6
	tbImGAGnb0kQCBGZo+H7kC2xI01y9TzsNcXBELezYu5vsF+7jIXU/elC
X-Gm-Gg: AYBFou3IuDqWidAFAov+pjFCwnuEWU/NMtvWoFWd6R80I4wnSPsdNGQxcBQ6JCDGoOu
	lUyvWxNugaQigM89DR4axv237fZMPg+R87qi5PMXhnnpCVBkFW4aGKbiOO86bbpxVcuY+MWBud5
	4sfxIo5LkOybkgcVJfwAxuVWBBP9wTvruyYAApYJ4zx+teWQ37IoguX8ES4wosOHcqEskhFHHYx
	rdZoXMsXKJX0/z+Ife808QV4F8DLnqkKrXNnSOdEqsVr8Z2RGGXJcI5wklEcr2i4qvQURue9YgE
	jY/jkpScPF4rAfWWTw6BJ2LV1qZD6BYXaCyOhIhmHPVM9OpD8vUK/lXxI055bUECh9529EC5gNz
	NHYKux0JXPWJpomO3t5kdngDtcMi5/NqD0WcT/tLLr3BkQNMeMMSoiiC11SRgSrMSfG5y9kz/Ay
	Ii5lTc9seLFaP7ja/jD90W36Ol1Yj5/ubUfPgeCMrVBr1GQzdzAHGHRuZwYW8sWfsUccQ2b35oE
	mgf4sF05UPLwpL6fjIov+BDHD0zeLTeVTb/UTEK/Qqz3oTrr9jsuUGbpetYLSfrfsgJggRJrxjm
	wdnm8ARcgJVHETf2N8buJRlJ0lpWZEL/9WSaq5FTJkGqWnu84KHK42cPcWjoGP9wUT6vGf01YGm
	/BeOXCCMN4LY=
X-Received: by 2002:a17:907:3f9c:b0:c42:fc8b:6c6a with SMTP id a640c23a62f3a-c4ca7a9ef71mr660488666b.14.1793536481629;
        Sun, 01 Nov 2026 04:34:41 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ec5sm275298666b.12.2026.11.01.04.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 04:34:41 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] backing-file: pass RWF_NOAPPEND to synchronous writes
Date: Sun,  1 Nov 2026 13:34:40 +0100
Message-ID: <20261101123440.3184069-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

pwritev2() with RWF_NOAPPEND ignores the offset and appends the data on
an overlayfs or FUSE passthrough file that was opened with O_APPEND, and
the call still returns success. The flag must make the write go to the
given offset even though the file is in append mode. Any user who can
write to the file is affected, with the default mount options.

overlayfs and FUSE passthrough forward the reads and writes on their
files to a backing file on an underlying filesystem, through the helpers
in fs/backing-file.c.

The flag works for the file that the user opened: kiocb_set_rw_flags()
clears IOCB_APPEND in the write's kiocb. It also copies RWF_NOAPPEND
into ki_flags, as it does with every RWF_ flag.

overlayfs and FUSE passthrough then pass the write on to the backing
file. They opened it with the open flags of the user's file, so it is in
append mode too.

For a synchronous write, do_backing_file_write_iter() calls
vfs_iter_write(), which sets up a new kiocb for the backing file. That
kiocb starts out with IOCB_APPEND set. vfs_iter_write() is only given
the flags of the user's kiocb that are in BACKING_IOCB_MASK, and
RWF_NOAPPEND is not one of them. So nothing clears IOCB_APPEND again,
and the data goes to the end of the file while the call returns success.

An asynchronous write reuses the flags of the user's kiocb and is not
affected.

Reproduced by calling pwritev2() with RWF_NOAPPEND at offset 0, on an
overlayfs file and on a FUSE passthrough file opened with O_APPEND: the
data was at the end of the file afterwards.

Fix this by adding RWF_NOAPPEND to BACKING_IOCB_MASK.

Fixes: 73fa7547c70b ("vfs: add RWF_NOAPPEND flag for pwritev2")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This is a followup to commit 19b18e01d0361 ("backing-file: enforce
append-only and immutable backing inodes").

It is NOT a security fix, but a correctness fix for both overlayfs and
FUSE passthrough. It fixes RWF_NOAPPEND being ignored by sync writes.

It had to go after "enforce append-only", otherwise sync writes could
also overwrite append-only FUSE backing files, as async writes could.

Thanks,
Amir.

 fs/backing-file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 5780f60662d07..c601b27f0fd35 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -115,8 +115,13 @@ struct backing_aio {
 
 static struct kmem_cache *backing_aio_cachep;
 
+/*
+ * RWF_NOAPPEND stays set in ki_flags.  Pass it on, because the backing file is
+ * in append mode as well and a new kiocb for it starts with IOCB_APPEND.
+ */
 #define BACKING_IOCB_MASK \
-	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
+	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND | \
+	 (__force int) RWF_NOAPPEND)
 
 static rwf_t iocb_to_rw_flags(int flags)
 {
-- 
2.55.0

