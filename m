Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B53803E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815863; cv=none; b=ZV2Bnq4fO1qDtmdn18TTy3Hz9y3ykLJC8LDmujIQnDYDvhxxAItkwUcm0+psMtwwpxIynInUdk+KjQSRk6A0MsuKj5pJzdDBZQvhZX5BX2b1J1AQK6Z/cOo1EuBMLGBDciOimyFWMkjMdNfosP063TJJ4N/SMyscfJeMYBsAMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815863; c=relaxed/simple;
	bh=PUuojCNELCKoaIkkmqQDOk5yIbSxVIW0zN5dnhUi/ME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LWOW+fqJWx5GTmP7SF+coS/lp4NPcOL836k8VeqGPsu/GAxTUIl7cgdOTp+LAnqCpu7REu4B7UaYeHKd/EPl6GKq8xQOsPfexhybiSzQawp3U/HlnhxEOMPexFfLQDezCZdQ07xZcYtisgn5XSQ+IhyZr3Uotc8+ytZCoxv7P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ6JgoSL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ6JgoSL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488afb0427eso23877455e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815861; x=1776420661; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7V2wf57jyU8Y8uJ3/NHV3uJqjb9+6yGjC9YCeBBCSs=;
        b=UJ6JgoSLeLdnZeT/0xzPY69bR3gd4Gc++Enw9AjsWJcYV6eV7gV2jBd+5hiSaWRAX9
         nUsZ4kRqV2ccyLbr4CLd8KY+KQg7sBEWw9eeAh5Tnh0Pzfw3TO1AQQJw/fqULqNOI8ld
         6ZQa2cDPGBsgPGXtQ4WP+YzS5smbsiqzGKq2RdAyvwLmAmHUuzk+RDLL/Q5Pc3O67y+k
         u4LY3RxSnrGBKgYr8hLlswHFNP5/zdRIMhMZsbx3mSn9em+WtUQOQiwp9HSzj9fPer58
         EkQLEdOuZimuu4jk7J9OR5dwYo5NTMmMNFXwZ8p3fadbzlx45iF/rTEYZN5D40S71YoM
         6Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815861; x=1776420661;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7V2wf57jyU8Y8uJ3/NHV3uJqjb9+6yGjC9YCeBBCSs=;
        b=dqccaCO5DG7k2FThatr+4h+eOmKkT26pfv+cqNQ+EPfugqhZhqE12pVPsldpdNAPrK
         e7lI1oKvecro0YDJ+jToX7iZjYOUSRo9wemGGAh3REzM6rlsNAHSHXn55ZaaFPcPKIPM
         tr6hldqpzZiQhBwlq4Stvt814cEr8vxpQfohQwCi1anKI8vNTkXRPPWQp8bpNu2Ttnie
         LGn5SwJwiCxKVjr6bIZy4+/H7dtOmKRQYbv2PKP4AW9Kq7T0PCM9b/jzeGa2wBMUE+/V
         aaps2JsJ7cMgJ0+Cjoocnmq9uOZX3gtwZSPLDFEpKvVLsv9+hyxuZxfxPhbKTdNSUhJQ
         Z8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLqJGrJvUGdwBlHRbRTZG029dF+FyHrf5WkolNqnhzHbqw56NrfzxfP0wwu9iXwFFJFQLIf12qejbv/+M+@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuJAkdJbZ1pniCMHjqq05FF00P+3eR9qvaKDZvi+K/PcEPVHH
	dvFWcvq1esbsJAp6Fnx3U4esozAZ4jmVrmtRmB9R3+qw+gV0IJmmC0kh
X-Gm-Gg: AeBDievC2o4H71I/PZUcjx79H42Fng2tzqxWkoIJNi3FlcsH8Th5OIWjbM2nGG6alqT
	bOxtq7+r31xTpaV+kFQl4u/W/iLDwYVTzeP+gIn2W2zjF0vWGkCNjeDmParbPSDOSpazc+o50Fb
	mbVUMA70fqlLMPGgOIeltDlEwltyz58/lM2gZM8dRtF+QObYWCtaN3sjESM028iYCToeTDYYuqg
	/fwhpCPDGNKcqbtTmGsW9m/OBdZYcI8mM/g+7UZ3tNRssTZCXCBzgfYW7oY+Hc8LXzZo4JwVgxM
	0C6Gxdu+qU+HOMiOnFfCBoxqGH5V3D2iFHh13mIeIsTMgMUaix6Ry1YioF2ll9uOeCdZ6KNyhiV
	odZQHUiEb5jWMWW2RNaLPXjJzuuAqaGWNlREvdgOHEbY2dnw27piTh7rY/VEHA/6QqpNrVSSHF8
	gXrO3HTVX5krt9dmxVSIM=
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-488d67c749emr24705175e9.1.1775815860819;
        Fri, 10 Apr 2026 03:11:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d538c39bsm58700195e9.14.2026.04.10.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:11:00 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:10:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ntfs: delete dead code
Message-ID: <adjMsTa3Xv7O3jWH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We know "ret2" is zero so there is no need to check.  Delete the
if statement.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 fs/ntfs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e5b897a6c1e1..b04919124989 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -534,10 +534,9 @@ static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = -EIO;
 			goto out;
 		}
-		if (!ret2)
-			invalidate_mapping_pages(iocb->ki_filp->f_mapping,
-						 offset >> PAGE_SHIFT,
-						 end >> PAGE_SHIFT);
+		invalidate_mapping_pages(iocb->ki_filp->f_mapping,
+					 offset >> PAGE_SHIFT,
+					 end >> PAGE_SHIFT);
 	}
 
 out:
-- 
2.53.0

