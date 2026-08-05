Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379943E3151
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914067; cv=none; b=L7fiMdwF0xKCM6W67muvhrFdg8R2P0Hpdnz3JXT4M2ACuoA+mphxOJOhqcUkYpt3pthTye+97B4EKOSbhrlk7zsuvxtKFfHJIT8f7N4SQvFQmO46DUtreeCidQdfNjbNlw0mpD2aJWLmWZv/KtvJRNVjrE2y323HNa5z0PwhQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914067; c=relaxed/simple;
	bh=xP/+S3gu9wUEZoivUbQGBRxfYBOOQ6HSp2fiTw8BxT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwnMDbVFuhFqpaKP97lsgrDWfR96AKkGTAnYNnQ1tRric5g0r3SrWnbLDzvJsqBS7TSvKpHG3u9mHH/OqliK57WfUP9SM9XI7yRrSxE3kYaUizLeI+uLOpAgEJiK3CEpg+PkiLFSlHv/3Pr48k72TDQX9PgkVksdgW1mb3Yrdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwdkUGyk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwdkUGyk"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso782625a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914062; x=1786518862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNUE3YxuYSlEa8cIidZ/GVsUJuIHpIRfbdJefsYc9As=;
        b=XwdkUGykmkgSd8ATmCOdmvLgM48Rhgk5AVsBINZca8rUE6VkmabFQaZFLWeeQnHEBO
         BJ3HMiHlCCTUFJgBl9OgOG3p1m65jF5ujgtY/36ie7BrfdNfiiMdguueouySe3BwTrFp
         QrI6gY+eljCY5G1/xjW6zDYDsbxjmR+YxRMRbaPaFKafP+Id6VjYAQs3mr5/yFBdx0S0
         n+7/a8qag+xl4H6rlsC7Cg4Gtcjtq5C+C90H2qnHGwDeFgZFA84pb6pX13r7pkGCVvRr
         XGsl1PJho/sDLs1km0RtfOpiqXA7CxAh4/IhqGQavk+5rrZz5VIQVRvzDj7YLC+/eco/
         Hc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914062; x=1786518862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jNUE3YxuYSlEa8cIidZ/GVsUJuIHpIRfbdJefsYc9As=;
        b=OIBNtZcvU5/CTC6Vo6VhsGzyjy1VMl3XVr6+lpqTEMNLFtgo8BVybQwmKB8cvPJxkQ
         zDIdDN13u/x74QSmp4Mom71sQSzkk0ndmQHpRkQSdZeN/3IekUdo2fN+eEsAGB603iQ5
         C74bHnNS5eJt/Qxzi5vPOwxuFZ10voO8VpYirSp0e/930dH3WNrGuM0TPd6/ckB+JuZz
         Qgg4Joj67O6bv/Iyf6uRKLpNVyJ/7tZR1+0jVG22nrzroGIcqgO9aYNH32L8zwp7apAQ
         db1h58VElHz4TZqTWU+FVAiDD0hcqlrsDJPgcW6DaZWIqFWpN05tiQGR+QyqbHoHn7i8
         Ufkg==
X-Forwarded-Encrypted: i=1; AHgh+RpioHFQVw5zyRA8C8Um3p7lzYEDk4p3iryELAolkeeMMv/7jlkt8drnrQfwS9nVG/tPoZb5ksaz1AvcSK0w@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0H6ri0gUXXKCXuBmfDig1cIxFFEI0LeiM1elTg4u4pVPmiR7
	y+3IHWA7JklbwCzJMWdMaUD+d584V1rhLSpU7HyA1nTiyLAZD2lx0W1D
X-Gm-Gg: AR+sD12LWXBrvQca4O0FdIVmnUh1Si+iygCWOW4EmBZEyXiat5jV4zIurt343rSL4ev
	olbw7EBxNruVpD+Xs97CO1WbOGn8/gyfB6ZcWz/cZRz5hStI9o7vTeypugMPKjXkzfkL2xOVORY
	aCGNBw0Dq7JWMjr200cXpzVFyN7NqfDv4UbVV553Mxk/11OMyKGZ+mtIaTOrpBcJlXFc5HAmljR
	CP4rekkGPLN7fMCOF24w/gdIFkh6KMwc6v7PFXOI7/9TeozXUa2Ke2VndfsxoQRzNFD74Qw1/X0
	NhnF3LMQRmFzadIumCdrvljjiuht0sZ3/PLB8FllxSyVXR7TY1UYyWzn+I2vYWDWIW/HdNDhyQ2
	j7mfc9Pnnly8eL25mkDXmbjqYkfy3XsfrzaZXxGh9cJhfjwA+pHjNI3eWa2tyU+qt4XBudl+Z2O
	2TizsD0aiNpda0SJnlHHcwD2VrUAxXnDIBcCSu/hfMDMTUMtMYLNXEEQBmRtovMZdZMr5XCd3HI
	IIfjBjNMca0KYQ/rjzD40H+2FWx73q5zvICGpNYTo/tfH7mUT84TGinKj15uAK/WEQYpVkiWPgb
	NAEEBN1hqj7QD2HDIa4cMGUtgV+ZzMcRpRaM5pnfCI/srWR5if4q
X-Received: by 2002:a17:90b:2785:b0:38e:6c37:d95a with SMTP id 98e67ed59e1d1-3903c5e1f07mr4992236a91.19.1785914062344;
        Wed, 05 Aug 2026 00:14:22 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392aef87sm2158639a91.13.2026.08.05.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:14:22 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ansgar=20L=C3=B6=C3=9Fer?= <ansgar.loesser@kom.tu-darmstadt.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 1/2] vfs: fail dedupe requests that cannot make progress
Date: Wed,  5 Aug 2026 15:14:13 +0800
Message-ID: <20260805071414.3414870-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805071414.3414870-1-matthias.goergens@gmail.com>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIDEDUPERANGE allows the VFS to shorten each destination range.  An
unaligned, non-EOF request shorter than the filesystem block size can
therefore be shortened to zero.  vfs_dedupe_file_range_one() then returns
zero, but vfs_dedupe_file_range() reports the original length and success
even though it made no progress.

Reporting the actual return value would expose this as a successful
zero-byte operation.  While diagnosing the over-reporting, Darrick Wong
pointed out that a caller such as duperemove, which advances only by
bytes_deduped and has no zero-progress guard, can retry that range forever.

Return per-destination -EINVAL when a nonzero request is shortened to zero.
Keep the historical result for an explicit zero-length request:
bytes_deduped remains zero with FILE_DEDUPE_RANGE_SAME.  Other destinations
in the same ioctl continue to be processed.

Apply this guard before correcting bytes_deduped so that no intermediate
kernel exposes a successful zero-progress result.

With this guard and the following reporting correction, installed
duperemove rounded its match to 98304 bytes and exited with status 0.
Installed rmlint exercised the guard: it received 98304 bytes of progress,
then 0/-EINVAL for the 1696-byte remainder, and exited with status 1 rather
than retrying indefinitely.

Link: https://lore.kernel.org/linux-fsdevel/Y93BkIA4Nd3IJAk+@magnolia/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/remap_range.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 26afbbbfb10c2..53330aa26b86f 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -555,6 +555,8 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 			info->status = FILE_DEDUPE_RANGE_DIFFERS;
 		else if (deduped < 0)
 			info->status = deduped;
+		else if (!deduped && len)
+			info->status = -EINVAL;
 		else
 			info->bytes_deduped = len;
 
-- 
2.55.0

