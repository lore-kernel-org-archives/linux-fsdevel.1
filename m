Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057845;
	b=IzfzLiWjddZCBhzMZavZly9mp3W/t9XAH5KasvMUmNY+cHMsfnjM7i7SWcSkiRWN5Tg6
	 e7FaHBGVVEoQ/yQmYlZYR3+AhP3eVb+RfZ2dpgj3UbNn6p2+hpovIQIxY9oQ9HSvC1ocq
	 IHBRj8q4lSPhuaDFzU+wTNuA6W3Ym9Ae3lNN20mSiSB2857wJ53xaJF9CfOgupkIUMPZI
	 qKK6B/EgnKDDF4ipIbajvwu7nsTPTuazauTtVZpD2X8vzTIFwE8CrGXgRz0Z32QhKfLZp
	 Ewd4vFTZZE9iOBuhG7gZbrl7pYmTD6mUsiFz8gvbg1uW/TszuRwtDb8rltULlImnO7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=76T73ntXs+yFh0/soL0doyAQtKkRUjwBVbAjN35jhWg=;
	b=OO+/N5WovpDGHWGNy019WI2Ff6sgXQcUku896fmkbAmArWj07+B4IAz9ZxYx23PF9kom
	 Yi2rWlCnst59VCcE+owMcpFy3NiyCE1KFuEYN1ZwgOtuM7eoNyblM6BW+AnDIIfqD32F/
	 hnyqWcMrs/ZzLGufoUAqHIdwt6vykcvn1KRi1jdfq/un+aHCwluKJv2r2B2/6aFbER847
	 599NTwOJnF9PFhoIMimMY6gKsymtTQvbsJnGwCCgG0jWGO+BQzy9rWdZq7a+Wwl2N7r60
	 7xN8G4WdmOlCp3kQebsQHyATLsRzdkEBi859qy45D1oma7dWmRlaxO9uGDPAB3hnMaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pyIkvM1c;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1D60A2604
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C1D60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pyIkvM1c
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1aefd1bf74aso362294c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 19:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057845; x=1795662645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76T73ntXs+yFh0/soL0doyAQtKkRUjwBVbAjN35jhWg=;
        b=pyIkvM1cCQmG+tfLh9i5xgpgkf2EEA/iG1+0t5rfHPr9VHhnVsCvw06LkdiYc6qkm6
         jhXToFdHUXGWs7Qk/8WGfOVmdPfsjpKMQCfeOWNAsBl7lRR1BLIB6mQ4TWScF2g7lo+L
         Am/YgbEkLxTIqrpa+MlcT8OEEaP1LNsVHcPQUch0CwuijiXRe/KJUtYWHg/xANpWfeq6
         SyAm//DHptUkHjGS89uxMTleKeaZ1gAKc9G5S9FB3Vky709JgcxtzU0Y6ZAtC03vE47y
         4CBlwULlois6tLC+o0Y48JeaX8hmEN4xSnp4G7mThECMTQ6KBrLnYsaQU9o8Q2z/HFF5
         NfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057845; x=1795662645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=76T73ntXs+yFh0/soL0doyAQtKkRUjwBVbAjN35jhWg=;
        b=fiucN+oB4zRwARKzz6uGIFJ/HBRZ1NluQ3XFqmB21LQdWY7VWZiNsa7uAD21GqKqXf
         /BqNXo2yvj67HI8DAc+4BEntusvAB9BUdUEAD67Okzye2vHjykG7e6zzefIRB5+iQpvH
         1rMtkDx5nkGYfm6/n6kcLHeAoBTM8qAEtEx3YHr8jYVoBLVcN0vRwNssK4RejWPeE8AV
         rxQ7civRwZ7x8jPzYa5M7PBKIVP1hSIVrtHAcFth/SmtqaAXtisE8O3HBvawZfinFGJR
         uq8ZxJ69eO9Jiz33QIldPcAdGh/fdCyK5wIz+dwoJpea/oItMDU6Alki5gZtpB7cCeQZ
         DzTQ==
X-Forwarded-Encrypted: i=1; AL+hErHCl/iMkwwbs0mhXv1NisEsxTqFv3cuB9CpZyakpcS6ZwNwzI6AP09Ph8eYf2IdcuU2mA5PD0G6ZzACAmIJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+bmXdLAT5aaY0jm+2qYIJC+58XLyNVoPcxavK3gwjrtC2Wrz92
	pgC7kmOAdYaduK/pWiEBfjWboDp1HRREuJniE0mXepIdQXT/TPyq7ZAw
X-Gm-Gg: AYBFou33PUHXLVA1evLxkHJZ0F6ZJS9Xjq6YfMeAZw3TYOZQ13DTYgwBp7IWw4l98if
	mVoxEi3zvdysGD9jMI3ickcJEeFQ4Rg6u8OHe8dr7hMcWPyIK616CR3sI3LQ9zIeo/TyF5kyWr/
	Hqc7lBBNRf1pIuHZ9q6mT1IcKL3HwconpC/EwhUvftP7WiBLuyKSz61YeXgqLrvWlRpZwwRQ2LV
	+1OfpvxMRc7LqP7I0ql7pgpOAqJHj2UV+ZXjvyos3HAjuEabZs0jL+FhYtKqaCChWFE3je3ABJ2
	OIg5wCLsOFBd5ljFK+HXSqN62wwlOgjcQo/cYMMblFYH43bOvO6ij4HmLsDXnlJeMyyEs343xz5
	bJtI3TJHYx/SepJ1+gPuGex2B8yEBGqjYc8A90Vcj23ChxrsrVY+6SC3Qn9zlnuTYFIaMo1Y/IP
	okRegxsv+NobgW7lm7C5sRZJY7M0ByQGkMMJ1QbgRH6LNkNedFcTeMAlwDjBgSwUD0Svf3MJVhX
	BIGhakCMEYYOsAMzE0ucDUzz8DBCt7JM4CAsj2xQOF2DqfriuVvvg/7VPqd81B8CDmljcBM+xmy
	friWw/+Ub73r5xd3Er+iLQZP56qgdi5jT3a/dAsleq3Hei1ddPjB+jQ/KhnqOjthvBOBGAo=
X-Received: by 2002:a05:7022:e886:b0:185:6c8c:d860 with SMTP id a92af1059eb24-1b54e8894eamr777303c88.5.1795057844676;
        Wed, 18 Nov 2026 19:10:44 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm15028118c88.13.2026.11.18.19.10.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:10:44 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Ding Feng <dingf3ng@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
Date: Thu, 19 Nov 2026 11:10:25 +0800
Message-ID: <20261119031026.7985-2-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119031026.7985-1-dingf3ng@gmail.com>
References: <20261119031026.7985-1-dingf3ng@gmail.com>
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

generic_write_check_limits() stores rlimit(RLIMIT_FSIZE), an unsigned
long, in a loff_t. A soft limit between 2^63 and RLIM_INFINITY becomes
negative there, so "pos >= limit" holds for every position: each write
through generic_write_checks() or copy_file_range() fails with -EFBIG
and raises SIGXFSZ, although no file position can reach such a limit.

Reproducer (bash counts ulimit -f in 1024-byte blocks, so 2^53 blocks
is 2^63 bytes):

  $ bash -c 'ulimit -f 9007199254740991; echo hi > /tmp/f'; echo $?
  0
  $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'; echo $?
  File size limit exceeded
  153

Before commit 9fd91a90cb98 ("vfs: strengthen checking of file range
inputs to generic_remap_checks") the limit was an unsigned long in
generic_write_checks(), and such limits had no effect.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX.
Smaller limits keep the existing loff_t arithmetic, so their behaviour,
including for negative positions, is unchanged.

Fixes: 9fd91a90cb98 ("vfs: strengthen checking of file range inputs to generic_remap_checks")
Reported-by: Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>
Closes: https://lore.kernel.org/linux-fsdevel/8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    v2: hold the limit in a u64. As an unsigned long, "limit <= LLONG_MAX" is
    always true on 32-bit, and clang W=1 warns (kernel test robot, Damien).
    v1 was applied to vfs-7.5.misc as bc0dc4379463; this version replaces it.

 fs/read_write.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b15522c..9786dfc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1693,14 +1693,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 {
 	struct inode *inode = file->f_mapping->host;
 	loff_t max_size = inode->i_sb->s_maxbytes;
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	u64 limit = rlimit(RLIMIT_FSIZE);
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		*count = min(*count, limit - pos);
+		*count = min(*count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0

