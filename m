Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F963CC9FE
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830747; cv=none; b=O0nMmIzxUW5DV3TV5J6lIF2pxZniMqvDZ5ccG/LHNFtW9iIRKvJLj1eCKHIVYOUlE9dcCatT6MJdsP1bb2ZLfi8EXPlYpQukGmW8uBAbhqFpR0s2SRQ6AcLaYSvvqSpj2XSc50Nmu5sMQqoj8bBm/nb7QG8DKUm9NJ25FbtNNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830747; c=relaxed/simple;
	bh=TwcYvbUAOnR0P7l2KWFuorORJhSrQA6oe8VX51ghrv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4TRD0jX0Fz2dRP1gh9c68lTrKwWZbEakvb5P8Gg+uZtnzV8Ze7Vvu93az0J6POGs/K8oIizbTOUyMVEO/KRFcTJmpezHxJro7X4cudj5lMbqy1gtLCqpy3IANQpvns6+bs3lgpqgKldqUke3MAVhKR9oqzB4eViysxwCSr8wVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jstEs3Qr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jstEs3Qr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso20134255e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775830745; x=1776435545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F94BGokyGX2AdRwzWyQMBNCM0wg/Rqsn529BpT6FiCk=;
        b=jstEs3QrWfJrMZwMCGpF4VptSC7itKfEcH8oooZdZPk1hGvjVmPS+49X0mxwpwL3tr
         7IgEuPgb+pQM6/311DDTIOcSLiRS2Ue1DKxYkZ0s7ooEi8L+E8K3n2EukV8H6ig6wgPE
         qSwSRh9I4MdD2H50jcX27DyZ1EL0I1oTcxTmc2Zm+tpp1vtjuO97egbjHKQ6uHv1WIS4
         tHtymCQHAdMIo1KZHWPbdJvZTcYQbHUon4ZJ95pS/iYWW5RlEelrBnIHHPECJQFg7D5p
         p+xWvS1Wd+xuNMMG0Qbg67l5V645t8DFuAzzCWJFJo5n8QKFtR8A14UdXvOnflYMu54H
         Abbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830745; x=1776435545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F94BGokyGX2AdRwzWyQMBNCM0wg/Rqsn529BpT6FiCk=;
        b=AVmyJRi8nyTO55CjNNMKenXzVqIUCUoy3OpcgmweOz3/PPzy8ApQMWuGFF/58is+aO
         mx5+KqS6QFgShGzXaTrpqIprPd0m5/sp5rGgHXqL/Zd/KyNI/KNS/0HmMpmdHyYUQZLx
         f22v1CdhQfXYnjAINxHlLel8w5RsYVqru31MlTUVp3J7BrO6Dw14riRMHOySNwz+XayY
         RMBuriyR2+7lU3qcPzEmlPYsQ2znq+Pg+FJswqtjF6BOPCF5IffTP7fSKM2LQYiqMWqU
         OOiOZfWqPweegQi2pLNNftkZ4Miqoa5ZTy6gedIsb7RUI752JFd9nbqTe/Lx1P/5kof+
         w3Iw==
X-Gm-Message-State: AOJu0YyDAnpwgeuKa4Gs2CxMn0JIdvXaluzOgTir0ZjqvvSniO6jSdk+
	CmHTXqKvOpi6m7Hlh1F6y7LQFjA+CdisWTfeYPf6wV3o4QUia/JONNbGzde8rA==
X-Gm-Gg: AeBDievSZEj2OF517IrnfvuRfYb+05n16hZelIRULN3fvsYmuW2GDuWfcg9YUBaplI2
	R81K9EdYrR3OGN8umUZ1/NHlgzguW7hFJKvO8PNcMyxTnXNG824ogVShVOomAFE3bU512VTgsbp
	a3OOmCjb4TcqHwVY+UGEexkIBmSHG/9Ou82GWw4YeAxBBJtaTW+ClR4gB3Fty0cmHjG/ay+YJlO
	kjc5cXYdXTz5HVMxUNQXU6tqJ8gSMlJ1qpQbLSx69Y7jUoLEF/GTBU5JWKsJGoL+pqNY2K7g401
	JqArQrZGhT/tje082sKFDh862QpCUxtx+3XQVAvYdALv49BfBaBd4IAUL7W20EwlWjySd6z86yw
	nJpdShZ6aY3N954bNeALKaI9wlWd5QTCjH0BKH7mmV9QnSQIUQ3bACeTkIQpPwnHzvebDBB/DeC
	A3FntH+KDf7ctVOKT2T5k9iLYWzBE3sB4ATIAXtFU2N54xlWzsVJJ/NC1yNmZN/fU2uDPCvGl+K
	UF4O+NlaO8=
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488d67bbd1dmr47209245e9.4.1775830744841;
        Fri, 10 Apr 2026 07:19:04 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63dec3b6sm7568186f8f.16.2026.04.10.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:19:04 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:19:03 +0100
Message-ID: <20260410141903.307959-1-adrianmcmenamin@gmail.com>
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
