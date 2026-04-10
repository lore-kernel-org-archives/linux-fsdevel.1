Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA33CE48F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833990; cv=none; b=UlDlnqrNyMSp0GV1zEnOc7uQm/mdhwb/rXtjkmIwoXYxPb4T4sWiLa2UvV/Cht1UC1n0BoeSG/lzyxwpI5nBKkL/JCYTDVwUM2J+YnNw7pi4tLyH48kQmoBjFM1wOyHE77kIl8UYtBeVm6F8e+FMV5GBzmROKqoBf6mZOWeEYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833990; c=relaxed/simple;
	bh=TwcYvbUAOnR0P7l2KWFuorORJhSrQA6oe8VX51ghrv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEB51LFiVszJl0KiOzHod8nuZJ9zYn7KO2S8lFWto+VAeraI0wplEh44LDxPpkTMCkqXvwrkUxLHoedMkhsOCeW/tUIgEIas2t8hAmDQjv1jpydw+FSQ5YpXuvMssTR9z7JHjAhjlGidDNIN6G50mz554OCcwCS4gBuX1vDD3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR5ZghIm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR5ZghIm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1442392f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833988; x=1776438788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F94BGokyGX2AdRwzWyQMBNCM0wg/Rqsn529BpT6FiCk=;
        b=BR5ZghIm19BFLHhGVa8Ib053HPuJbkzIDcvBFuk/+j0X12H7PfkJucAJOAV2FYkPcV
         cZ4ctPCyhOzJb/VmzTI2LG+eVxDrzcmR23/b3Hsck+QkLw+hnGrIpFB00ZqKhuCgSek9
         5UQqD0sGNu22eBbzS0eL8k72+50dZRIDnvENCLJLC3yPu1rr288ZuE33WChN0VPTgU+p
         94MbHu10/C8eODVhNsjUojhrPb9Hpjhi5gk6AnHqEL9DcgLX1cB1l/VXnHHENcckOtsP
         UwIpv+/KrzStTGP8Rj32JWXeQ2X+qmsf0t4GGcb3PI/8gT6VWjUQlr+JiPFZF82AqINS
         6RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833988; x=1776438788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F94BGokyGX2AdRwzWyQMBNCM0wg/Rqsn529BpT6FiCk=;
        b=O9FHbtr4W2KEaloRkp9FdZ7kbXJ12TqOkBDGmiu82yeNUNsP5Uj1d7Zdrsv6xqrC2Z
         xG0dJ1RgGqi8tO0PJngc0LB3ZYs4Pr7KMF08pa6sJk4ikTHz21UuARt0RIdc/x7QYVUQ
         X0EDukVPnSTO7to5Gg/rIFREwUwa/69z9uJODompezk2e3/Gs+gA+/GAIXjyde8TSqCQ
         7grgI5HrAoUdu0nDzYGAWCAJGU2iGZnQK6yXYsG57WozoXvi6LJYH/StVy/CahMWhpEm
         f6p8KctQns6syq87Xi8x4IREgTZAVSlhEoEtN3mP8a10x5FtiVv0sDZfeI/KtbDyL+gK
         td8Q==
X-Gm-Message-State: AOJu0YwJNaLRb2wyHLY+titHPic33DJKxpBu/kmALTLLzrBwElAnKmTn
	mc5cOxeYDUZDR70dsuAo4bmxX929VU+m1eZTnzgLyyM6ikx+HR5HYilksie6fA==
X-Gm-Gg: AeBDieuDHGxE8W6fc4+CbIHc9xAiPdB/7NHbYifSOWKbFPPJ+ZdLkg4aGH5B9y6LHPS
	2s4ADNFiiOViGp7g/tLXv3fxv5gDyenaUopaRx7kwHYLiH2HRkjUxjUrTnLBLAS6jkdLKrleWBM
	AEgxuFBpnm/ELTZyIpnmwG8l8Lx80b/GwuljeU9OfwUChNyExDdWOw4RoSV7oH7iWHG3aKCg0rz
	XGIzj10ij4plOEjgbNHPb1SsZ/wekLKVrI4ZizF99Nz68mYDWQofsAU9u2pJGDzboPZxxoVAEBN
	3x+ssi0ZmzeRaG+rFQT+2tn3SKCmvmftay0vuu9Z5Q/cv304/a+vEBC/T782vAFqbxGJDPHpxI+
	y8FJHqHtabgsIGWdoVHmui3Alzh9EJITYjhrOd/fmpxBghGUchzFmS2RpCCH1yLWIX4aBZOwMyq
	WC8DY77kKCQVfsyRBgHqugC6k9svnbfS5Qf627If+C8YlEmoZbMfEPBXPHnP235Ke9kGInwCzBm
	ogQx3ceH5Yj2xu5qq4hkQ==
X-Received: by 2002:a05:6000:2411:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-43d642c0e02mr5719811f8f.33.1775833987398;
        Fri, 10 Apr 2026 08:13:07 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm7835787f8f.30.2026.04.10.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:13:06 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 16:13:06 +0100
Message-ID: <20260410151306.309202-1-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587d..893b585d17a9 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -120,5 +120,6 @@ Documentation for filesystem implementations.
    udf
    virtiofs
    vfat
+   vmufat
    xfs/index
    zonefs
diff --git a/Documentation/filesystems/vmufat.rst b/Documentation/filesystems/vmufat.rst
new file mode 100644
index 000000000000..2f7230e8e390
