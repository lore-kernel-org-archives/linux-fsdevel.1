Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314762;
	b=ACsNe70PVfJMqJayeZv9DMpOFt9jI6Ohuru+ym1tYCHUkjAWB6saAdqRPzy21qDe3y9z
	 IcQR9pCpVDT82CwNhp0LGl+mpKjbWWAN6uT8VGFrHPRVVAIPrIOMigFk4eZVFescu9Z1a
	 rZwmyfUTGaHXUcYmTDwH808ezAeb9nJ1QYOuAiPXrlrN1EyMXsnPpCh0p6pw2rKaMB3Hq
	 ORBvvOZVYg5kgmrGpkEYWLNXdy6oTe00kLr0ql84bcz80C+unp/iCjVv5BYCrI8VQWqvN
	 XGz1uokR2v4uU4p9QLgwimagC58Hag9i+e/RddEH9RD1l3oAImPJWI3oVpuT6mFHB/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LoIbjYHReLG6WDNOTPVhVG9Y8H5GzjW3qhBS6aSgkkg=;
	b=hIfP7jVa/wDZWn0ojcEPSsdMjcWB4HGcVWbIumWEsG6I3VK6H+FdvoJUOaOu+37eNQnG
	 muNRmxnX2RAsGT712ZCMR21bvY2PRlVaw6N/h9U6dHsydl+FBel8eJY5b5Ha4m71vog1P
	 kOFZ7If5kweX5Sd5PXsNdlpPCHjM+xZcl1E0ndpdmYhekaWsNvVdZ+autAJJGlGD4YjnR
	 ioti7by4SaHIlnaMmNyjoS88GbXQ1v+PPJfWuBTrmV9TqkP3BCp3JwL7vax7xQen07Pm0
	 4L1HEsRIoow1iO7TTU/TLBsU1N+3dhXv7YZAg9Z/radrS0Wj6QG3fYjRc8Q2S1JqXFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7NsA0p5;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C0606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 22:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B9C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7NsA0p5
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so11771c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793314760; x=1793919560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoIbjYHReLG6WDNOTPVhVG9Y8H5GzjW3qhBS6aSgkkg=;
        b=G7NsA0p5fd/KLkSMaNXs1QyoEcDtA7SSuLtzJRGLXleyUbtLCL0K8yUcVeAlGuTf+X
         6zc9IQMYX5xptgxuLEDlmexa8j4dwiS9UfUsVJYn+Ql0WSpFr9f5zfPE2HGhMC9vcAIw
         znsrhkQ81XEzh1Fa1VKJEJSH6pfraJ8zeSz1g3O4M4Yogk6ytIIbOqqUIHNpFDJvA6+N
         xejnIxBz8NgbRRLhV9ZJmadxoCa1o7v+ktEIgOfg+HQdgPEvlNt1Lk0a6Lqaz0Krjq4Q
         cs8H2bXMD/N+PTImO+AzRLW4/9lxa85vHoL6o8lvJUcvwbwEHX7ggbdaxOdMt2lan3xo
         z+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793314760; x=1793919560;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LoIbjYHReLG6WDNOTPVhVG9Y8H5GzjW3qhBS6aSgkkg=;
        b=JGYRh68+2GsXvtg6jOkmGhYxu8y2XqHbLSZnNOyhMw8rlQqrpnXSaJigA/Gsj9xWvj
         dcacuK6Y9V3TWUBfZxGJyofs4+E3VHCG0a3C3Xqp92rpnmoWccLFL8jM2dT7q/s9kmQZ
         algACOaN4bSXzHU1nPO6AjuCRkYlaR40ov+BlxC6yxd49Ngezul3lhx9vgkCZPLNp37C
         ggDQCOmK9WX2GbUdgrYJnY1zhAefwI3PAkfEsysqvWjIYMvAKDOHxcMmVSzvrbcB42lw
         XqTjOXuTYCISwTfihN+YUJEzLPFCuHONi5+8Vc1VpYEM4g1hNjX8bpVzZXRSiQVczEQt
         wLhw==
X-Forwarded-Encrypted: i=1; AKwUvBw9o26C43pNIAXHI4PaWhOhe5qidX+3/5yZYt3Wd9ZeAfC+2v3lIqs3lZMlR89OBnnSle0cONVj6dre1iuW@vger.kernel.org
X-Gm-Message-State: AFq9FYITHRcf2wuzrFiS3L11CiBPXeFXxFuZ9WCNJSZXVvuxvuR6MSat
	DkQop0KCVxFkxfWXhVjbN62TmFY6Krrisv5ICeNlNQSOdhU13+D4aeRV
X-Gm-Gg: AYBFou1DFOjvpzVAN7n73+bVzqmHU5O5cV4Gfd39bJWUXUGKbnN13R6ln98mf2B2Wwj
	zJOghnPd5cQ+817d854KSIkPG7WyjKhjKnNfRDFTP7M4v30dZnv8w539PThiyY27psWOM3MESUy
	efZ39GG2qhTZO0HFbs5+n/q/Bk1X/xsujEo93XSMs6vF2AGTGDALYNRgLD3Dv8O79dQafzXPzRB
	xlv1MPiYyizuxj5JFKD6AClHl0w0aodRxlvlCylL/5ARAnlJI8eFacoNyYv5ih7xj9yda1SiIIG
	qwselozSqHGJwH/5jPjwL9omNbo2d0LaOO4wi1250CwGXfjjZRalpuCSDYsCerBcQK8DRYKUXC6
	hYsJJJ0g0zV+Qg6Tw20qfLWrrBPzcldY2TjzdL469nc6HXO3lWqvaZsHZqdITmdQogChnyYOt68
	C6SOZKRZI60Xvn5nz8+841Y4tbJ5fIa9Cne0U71VZJ7cjK/Hc8m9h8xm2ztBa2btB5qF1NkXDVB
	KUbxGc9V2k7bAgoetP3EXh10hWx013qszvehLkurbPMj/aTYqw8UQBIl8Z7N1OkuVyUOebOlmC6
	zDEoJkxEnQx8L31Q7oMweZLShgL3TrvbhWbphedpsrfn5PovBanNnm43
X-Received: by 2002:a05:7023:a89:b0:1a8:9857:2102 with SMTP id a92af1059eb24-1ac5f183841mr660166c88.30.1793314760261;
        Thu, 29 Oct 2026 15:59:20 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm2009723c88.10.2026.10.29.15.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:59:19 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	xfcyhuang@gmail.com,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: preserve colons in volume labels
Date: Thu, 29 Oct 2026 22:58:56 +0000
Message-ID: <20261029225856.1173-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

With the ads mount option enabled, ntfs_nls_to_utf16() replaces an
interior colon with NUL. ntfs_set_label() restores the full length, but
does not restore the overwritten character before writing ATTR_LABEL.

For example, xfs_io -c 'label -s Backup:2026' succeeds on an NTFS3 mount,
but the label becomes "Backup" after unmounting and mounting it again.
The same-mount cached label still contains the original input, hiding
the on-disk corruption.

Disable ADS parsing when converting a volume label and remove the
incomplete attempt to undo the split. Volume labels are not stream
pathnames and should retain their complete contents.

Reported-by: 晓风残月 <xfcyhuang@gmail.com>
Link: https://lore.kernel.org/ntfs3/CAC_Ok8x21q=Fy4n7V5j78G3rn5ByHpLVRiM4FrYGaJnmdFiP_w@mail.gmail.com/
Fixes: be310476e886 ("fs/ntfs3: Add basic support for alternative data streams")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
This applies on top of:
  [PATCH] fs/ntfs3: preserve colons in symlink targets
  https://lore.kernel.org/ntfs3/20261029203457.59990-1-dennylin0707@gmail.com/

 fs/ntfs3/fsntfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index b06de8566a72..df939ee18904 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2668,16 +2668,10 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 		return -ENOMEM;
 
 	err = ntfs_nls_to_utf16(sbi, label, len, uni, (PATH_MAX - 2) / 2,
-				UTF16_LITTLE_ENDIAN, true);
+				UTF16_LITTLE_ENDIAN, false);
 	if (err < 0)
 		goto out;
 
-	if (uni->ads_len) {
-		/* Undo delimiter parse */
-		uni->len += uni->ads_len + 1;
-		uni->ads_len = 0;
-	}
-
 	uni_bytes = uni->len * sizeof(u16);
 	if (uni_bytes > NTFS_LABEL_MAX_LENGTH * sizeof(u16)) {
 		ntfs_warn(sbi->sb, "new label is too long");

base-commit: 4a77fa820d937fae9fe0bd6a6795c2d749fd4df7
-- 
2.43.0

