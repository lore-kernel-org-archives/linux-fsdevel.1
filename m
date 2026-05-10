Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD623B38B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433084; cv=none; b=RYlplyDmhdu7EGlIZSkx48P5x7/5mYTKktko4Us6Ul7aV/GKrI5u4X5pgYAVLE1W/cQPKw/0IYpHueRP0hUy/x864Xfnto1CD7e4nw3HRX9kYai6VLiTOYfZtfnEu0Ov0ZHg59VYcsyDooD9hNejCQgx7cGDBe8dzo7131KmDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433084; c=relaxed/simple;
	bh=NoNwR+koRa0QOEZpb03BvwCVGNJoaWPLcHTsujeA43Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwlJK0Q7PrRTBtp40XaqcVC9AkpRMol03xHyc8tnukCTXTQSBRl3co9t0jWNGhj7HBShGNfuUgNVULksVtbYOTS7JevGXt1aoIif2Ueu/dgmxNgBARC+1z5nvCII9eYbY2JCPYdOHNGna1IQIPWYmdwl6CpaVQjiDmD72/uZm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5FV895b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5FV895b"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36810434abaso131552a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778433083; x=1779037883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foA8I8Alm8eV4RIgBRmswEntkfZ9lWSL6CHV+T31Sok=;
        b=c5FV895b+CGkqIwveb7hYZUQ28kyUNQPITSr1F4TQwMznpaOeDry6Unx74RRGtMejD
         qiFbBYNqVU/YrzzSxe4eDjDESwpxcfP38f55BcAaFAYJLx4pAo3RfOM6DU+ekIOnR0e5
         1p4icFqrK03bACKdfWWgcQ+8aburny6Z2ZL7Iu8RN4/L/klo4MreNkdURY73EIHJUWHW
         fvwA5N95/dQeYktrvY4IHUa+OOWCf09Mn3n68iXuqNSrwEG0xQSQtbthhCK2LiK4HIJM
         aQ8sfvGX4E2Om5c1vszaIuElmTbaw7kF3Rk01FEUFk1KZjqxEGNJRopPTwM6Y0mwlZUX
         7fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778433083; x=1779037883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foA8I8Alm8eV4RIgBRmswEntkfZ9lWSL6CHV+T31Sok=;
        b=pEedMf9VsiMoFtrhqdkX9sM4rRYnehAiXSIXS6CQwLpoaHZaGVC9z4G7yj0Eu9jJN1
         tcYYZ7zA3DYlavpC0dw+49RPNyYv75WAgOzpI7P46fOJmSqlU6d9TaEWlaZ2o+m8n7zI
         XUoLkvgwvdZPixqDjUzN39RfRro2lNJ5ADhtw6A+BnskwCL0O5qiFffNlRHwLujzhf5T
         I7wS0bKSBIEIGCYLKBhjjQZN1mWg66QzpiB1/x+EU6Id/NAPzie545uwf+9Z9bI4XTI/
         0vUDRcx0rAuXDnaWKQnamhuRWfgcUCePNULk6OE2ZFii9EglDR6yR3XuYnwKZhgKXe/R
         T9hg==
X-Forwarded-Encrypted: i=1; AFNElJ/GJ07k3hVL7A9IOt2qReFW9BaLUUx2dycixECM2OTwr2iDY2dXiPHT241BJmentwWcOG9J/f+y64hNJ90O@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4sOu6A7PaO8K+r0DzQhr6cvW+x19g6aCnTT6b1ue8nOCDIzQ
	WaOV6ubZ1Ae6YR40PLSKkEFRBAKWNyMTALk1lX9jzFNCNrnwRz/X8oGY
X-Gm-Gg: Acq92OF1piJVblkdFCGSNZQUUVUGyKKpWYMAN6y8Ve4p5fxPyPn0bl7IjCeeeDFGu3W
	7hNFqrDhp3R4VWlIlM3OVqnYWZBW0Yr9VfH4BfB7vZdFSOLmNgxPnnfQcPqwPGpoGD/YnWL2XG9
	6RV1WR4+ROFhHYcYt2LMX+amSTdnjSkFN04MnIEP0SUJzmlRSAS6dKuwd1qPdndnVASfE/v1WXf
	sqJZ4hswmJaJbnQLm0cFJjsIxQkfYD7my62xiOOwM09jwhHo7QpiBj5LanBjhoKG5eoywWJvPi/
	+3VsstLtn6jNbvX6XHJtdlaZkZj4wbU72/Xsx+zo6/3K7ro4SowoWb+GPo7hdah6tgX3cFE6BqQ
	Z2tVCGQfQvx7ut7Ye3CKuB6KJvBt2qy7a9IddmGftSujWM7J15LcPR70mgHzrFNPuTF1C+TsPe5
	nFwwGx0kBxT7v48NdH1MFpLH+SNN54e4Mxb8R6YQ==
X-Received: by 2002:a17:90b:2705:b0:362:bc8a:9c1a with SMTP id 98e67ed59e1d1-365adbedec1mr11467306a91.8.1778433082991;
        Sun, 10 May 2026 10:11:22 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623fa47sm5120690a91.3.2026.05.10.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:11:22 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ntfs: restore $MFT mirror contents check
Date: Mon, 11 May 2026 02:11:14 +0900
Message-ID: <20260510171115.368494-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510171115.368494-1-charsyam@gmail.com>
References: <20260510171115.368494-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mft_mirror() still computes the number of bytes to validate in each
mirrored MFT record, but the actual comparison against $MFTMirr was dropped
when the superblock code was updated.

As a result, mount misses a stale or inconsistent $MFTMirr as long as both
records pass the structural baad-record checks. Restore the comparison and
log an error when the primary $MFT record differs from its mirror copy.

Returning false lets the existing mount error handling mark the volume as
having NTFS errors and, with on_errors=remount-ro, continue read-only. The
default on_errors=continue mount policy still allows the mount to proceed.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 22dc786..e8ecc52 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -979,6 +979,13 @@ mft_unmap_out:
 			    ntfs_is_baad_recordp((__le32 *)kmirr))
 				bytes = vol->mft_record_size;
 		}
+		/* Compare the two records. */
+		if (memcmp(kmft, kmirr, bytes)) {
+			ntfs_error(sb,
+				   "$MFT and $MFTMirr record %i do not match.  Run chkdsk.",
+				   i);
+			goto mm_unmap_out;
+		}
 		kmft += vol->mft_record_size;
 		kmirr += vol->mft_record_size;
 	} while (++i < vol->mftmirr_size);
-- 
2.43.0

