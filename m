Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E8562602
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092532; cv=none; b=OwdVQw3eLAkC6O8n9C9+2iLWUpyUPtipdvtzVSAeYn73frXKxG8dxmrGxtPRWg8i1d+L3/XIg/mNe2dgcoX44RgN/dMjXVbzQZLrcitQj955To8IEEjPZ4t76N8nzfvpI4bGs3Vwg3lTYU+9E8zIRW5hFesL5crsRRS8UboaZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092532; c=relaxed/simple;
	bh=0o1i8r1M9sy0+q3Vj2qZMykGNwX6I9ms98Xd6JXv0j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+uB+S3SNFAAxbXxonZ2GV/mXZFduMQrrUJkbzyn9jq3uEMhTt2l9dw3CzvI8nR0oZLKv0LpylnRbaib3OUiybqCy1CBkQ4w5M0vBf67Hlt9hd2PF/t/0zWLv3VuQqfmVuGwftWlTvIhvCGQQEY3Z6tO7j4okzQcuJh7Ur/gjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEZcjqFD; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEZcjqFD"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so108303a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092530; x=1790697330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d51iauC8n/sRqGdtQd7OF6cXgXxpaQlDT6PnPgcL53c=;
        b=QEZcjqFDRtjQq8ZjxExN9IoX9BiglQLnbc5cPAnuBdYJy38VZ5bw5DHBkOsAMOVCDu
         c025H4ACvL9YMdcWqBFjNCavQhU3SRCjIJ/nIPeCuB4I+ZLczHLe3sR69xbyBWi802tH
         FHvzSv94rHbKQezWVch6TmogE6U+zl5Mx+Kguobua/ETxTyF+7645xw2ln4ZCvqgw650
         Ut1egrGx16tow53V9LzV+9ZP90JjTevz3xnj7nyE64sXNQ8U3QZ2F4tGXxR51qP7pmht
         GXSRgLL+CTjn41Jo8XB5eMTxBag4FNlyp/GckEEfztTfynCfuLJmRPZTowZ0jmfu/yuZ
         7NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092530; x=1790697330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d51iauC8n/sRqGdtQd7OF6cXgXxpaQlDT6PnPgcL53c=;
        b=NWxAdIBh2tf9kNNU03Ah6Z622Q7FyzJHlMhheu/Nk0gxXXBEKmisM7Zr4kFs9mq6/e
         MLkIrfUXdwYnPnobCYn6+BBxBodH3G9PcCzn1kyYEDoSrDOGqJV+lIUSsdrhB3f5qAQn
         sfQoF3wkS8M6hxU7qUzQQRoMyScBMb5TRrguto8csjeci+cAt9l6zRBRjnhRihypCdu6
         ILWMzKPlhmOJ2HXkWqm0A48LItrQPzrw4ehtVU2iWgwA4dXYLaOcJxkngthEpaDMCMsR
         2tGouLkzKAgxMNoJeCLdwekFe2BI96e18GCk8yklOghxZdXOQzlpAL4nyc8soxiOxxwT
         jmvA==
X-Forwarded-Encrypted: i=1; AKwUvBzBcmiLqI4XWMO/uQxm6poJthOU6V4cLSLyPyTesJHAxCe2at7WrboXzJvhPD00c0JSb7YxHfTp6Ka0NOkO@vger.kernel.org
X-Gm-Message-State: AFuF++l5hlcJzFoKhRRSyYuz3f2htOg3STqEzDeBseOGan5G4zfApOq/
	ecyZbLauMZQ8Nbhv8SOgwJWz+K5VjVdKnV2rSLA4UFyARLfg2KyM/eexFk7S1Idt
X-Gm-Gg: AYBFou1oukVBYydbJUhWaKE/so+aXVMc4qVJ/EkGCW08xrWOzCx7rZ0PusnyEaY9E49
	Bi1+fz0XPYjD33vyf6/nMMpIlunFB5BcF5JmAvi3KoGj/VwvIKPoXLWj9Hr1ES5w1blNDL5m6f/
	eQJSSGYTgVzZhOZ5eC9ZTIWD04scaH44KlI5v3preprnZbLpe+euv9IW4gMIhuJIXI562W8fM3i
	nYPeYfU0JSR+ZcEnqeir9B40f2mprUd9yuHsVZDecIOdzfk8E8nnbV7SQT4nAIgkPszjwlVIO1G
	QOh8yaU8r/vbw57dNQirbKQLPxJAj5VDlYZLTP8hUfbNPoIoIMIFMTgGyD4wBcW2nDRj4E2Yg1B
	9RLlLTr1ARIM5BSj+853XGeL8TIjlq3GidtDWpa3yWtPe5ZeLIbn432HCaIfSc61c8hIA8oPCIb
	qeNHtkGg23CUGP70ttrj/0P70Y4XxGh75InmJfwCgeUw6SPj2LgT1zMM2nCxr4vGkLB/+zA84vb
	EmPGn/JmIdPp3T39PnTd1BuuwdNIurclpWYGRDDCf5EgOTmPnQHZnjxyVzxpT7SAyGa/QBsisR7
	nQ2gyZEG6GqsDMjB1RqmpjrNInIl5IlPvfWTMXYPI4QpqHB3GyCEN4IM05qWqXI=
X-Received: by 2002:a17:90b:4e:b0:39e:6c6a:2098 with SMTP id 98e67ed59e1d1-3a073284a42mr1897290a91.57.1790092529655;
        Tue, 22 Sep 2026 08:55:29 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbc5451sm83910a91.7.2026.09.22.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:55:29 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] isofs: size the name conversion buffer from a named constant
Date: Tue, 22 Sep 2026 23:55:23 +0800
Message-ID: <20260922155524.1993425-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922155524.1993425-1-matthias.goergens@gmail.com>
References: <20260922155524.1993425-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_readdir() and isofs_lookup() each allocate a 1024-byte scratch
buffer that four converters write into: get_rock_ridge_filename(),
get_joliet_filename(), get_acorn_filename() and isofs_name_translate().
None of them is told how big it is.

get_joliet_filename() gets this wrong today.  It passes PAGE_SIZE as the
output limit to utf16s_to_utf8s(), four times the buffer it is actually
given.  That was correct until commit b2eb2e288604 ("isofs: Drop support
of directory entries straddling blocks"), which shrank the allocation
from a page to 1024 bytes in both callers without updating the bound.

No overflow is possible today: de->name_len is a single byte, so the
largest name any converter can produce is 763 bytes, on the Joliet
iocharset path ((255 >> 1) units, each expanding to at most
NLS_MAX_CHARSET_SIZE bytes, plus a terminator).  But nothing says so,
and joliet.c says the opposite.

Give the buffer a name, use it at both allocation sites and as the
Joliet bound, and have each converter assert that its own worst case
fits.  Shrinking the buffer, or NLS_MAX_CHARSET_SIZE growing, now fails
the build instead of silently overflowing:

  fs/isofs/joliet.c:46:1: error: static assertion failed:
    "(255 >> 1) * NLS_MAX_CHARSET_SIZE + 1 <= ISOFS_NAME_BUF_SIZE"

This follows fs/ntfs3, which couples its name buffer to the on-disk
length field the same way (fs/ntfs3/dir.c: static_assert(NTFS_NAME_LEN *
4 < PATH_MAX)).

No functional change.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/dir.c    | 9 ++++++++-
 fs/isofs/isofs.h  | 9 +++++++++
 fs/isofs/joliet.c | 9 ++++++++-
 fs/isofs/namei.c  | 2 +-
 fs/isofs/rock.c   | 3 +++
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index c7ca7603e97a..87c64612ef7f 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -50,6 +50,13 @@ int isofs_name_translate(struct iso_directory_record *de, char *new, struct inod
 }
 
 /* Acorn extensions written by Matthew Wilcox <willy@infradead.org> 1998 */
+/*
+ * isofs_name_translate() copies at most de->name_len[0] bytes one for one,
+ * and get_acorn_filename() may append "," plus three hex digits and a NUL.
+ * de->name_len is a single byte.
+ */
+static_assert(255 + 5 <= ISOFS_NAME_BUF_SIZE);
+
 int get_acorn_filename(struct iso_directory_record *de,
 			    char *retname, struct inode *inode)
 {
@@ -237,7 +244,7 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	char *tmpname;
 	struct inode *inode = file_inode(file);
 
-	tmpname = kmalloc(1024, GFP_KERNEL);
+	tmpname = kmalloc(ISOFS_NAME_BUF_SIZE, GFP_KERNEL);
 	if (tmpname == NULL)
 		return -ENOMEM;
 
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index dacb9cdae4fd..2af41cc23f38 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -5,6 +5,15 @@
 #include <linux/iso_fs.h>
 #include <linux/unaligned.h>
 
+/*
+ * Scratch buffer for converting an on-disk name to its in-kernel form.
+ * Allocated by isofs_readdir() and isofs_lookup(), written by
+ * get_rock_ridge_filename(), get_joliet_filename(), get_acorn_filename()
+ * and isofs_name_translate().  Each of those asserts that its own worst
+ * case fits, next to the code that does the writing.
+ */
+#define ISOFS_NAME_BUF_SIZE 1024
+
 enum isofs_file_format {
 	isofs_file_normal = 0,
 	isofs_file_sparse = 1,
diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
index c0f04a1e7f69..b1f4a105ee87 100644
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -38,6 +38,13 @@ uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
 	return (op - ascii);
 }
 
+/*
+ * The worst case is the iocharset path: de->name_len is a single byte, so
+ * at most 255 >> 1 UTF-16 units, each of which uni2char() may expand to
+ * NLS_MAX_CHARSET_SIZE bytes, plus the terminator.
+ */
+static_assert((255 >> 1) * NLS_MAX_CHARSET_SIZE + 1 <= ISOFS_NAME_BUF_SIZE);
+
 int
 get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, struct inode * inode)
 {
@@ -49,7 +56,7 @@ get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, st
 	if (!nls) {
 		len = utf16s_to_utf8s((const wchar_t *) de->name,
 				de->name_len[0] >> 1, UTF16_BIG_ENDIAN,
-				outname, PAGE_SIZE);
+				outname, ISOFS_NAME_BUF_SIZE);
 	} else {
 		len = uni16_to_x8(outname, (__be16 *) de->name,
 				de->name_len[0] >> 1, nls);
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 010682f5901a..0146aef58b10 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -153,7 +153,7 @@ struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned i
 	struct inode *inode;
 	char *tmpname;
 
-	tmpname = kmalloc(1024, GFP_USER);
+	tmpname = kmalloc(ISOFS_NAME_BUF_SIZE, GFP_USER);
 	if (!tmpname)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 2628f31bd3a5..7d95443917ea 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -204,6 +204,9 @@ static int rock_check_overflow(struct rock_state *rs, int sig)
 /*
  * return length of name field; 0: not found, -1: to be ignored
  */
+/* get_rock_ridge_filename() bounds the name it builds by NAME_MAX, plus a NUL. */
+static_assert(NAME_MAX + 1 <= ISOFS_NAME_BUF_SIZE);
+
 int get_rock_ridge_filename(struct iso_directory_record *de,
 			    char *retname, struct inode *inode)
 {
-- 
2.55.0

