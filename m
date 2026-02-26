Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529F364948
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122170; cv=none; b=eolHxHHXelWL7eZ7wdBh1ZMFf9hV6mGR+x7k2/Q9so3Ct07S5h7S/0jIIEHXVfdwn+pV7BdaIGH/rnragJdDUVWQQxvKWM7VTLged2/ZTiKO/9ofzCVHL5xLJoGl03fGxAleS7hBN8JXO/7WPz7vW0Trm/ctS5EmvMHdnH4UF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122170; c=relaxed/simple;
	bh=uj2m9nZnDSBdfj+f80k+/O5GrXcuceIYIYVvbm+ed3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmIEHE6DlXccOrZBzhAHt9wryhAtn6CxGMuGm6xpc2/MgkZGSKt6nK9pHdkRXClfW8YFak1IRPOtr/iQkAQNjp/96eZFqGrE+ceGUdJ7hx6Antkq4PqjcHQSQ6RL8BWHO2HwCL2CQfXpwYB38A9istWW1RHCmrJB2exU8BMJcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK2357vu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK2357vu"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7985d11da10so10201087b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 08:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772122165; x=1772726965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4UlBcjO6EgElWFbuJfjo44BGajwbLVGVs3YDQi5Dfs=;
        b=FK2357vuV/t9ezbm/LUXZffpdOJ8XgwVLuzUjljsA/FVYuohj92YfUecJHdV2sKE4i
         qxj247aaQtmZGPNuSrlTCWFBU446NLRTg2BPpsXxSTl45A1yK4rrgYBCPyefSKy29oks
         2CsKGmqczmL7SqFz/SIR0OuWVsXBsrUe3JCUCLRedSEqoyHPHAq5qMY2yg4WPenDG11n
         Z6a0D9ULbq8HqNf8rIjqKtGOKgMhhp4zt3ENlafVVj7RFZhGgoi1Z1YVbcyP2626I+vi
         +LlsysA96maw2FtI4dW15nRDwqkImDPzvoyreKOB7g5FHuPb75/QRFaMBTYk+FczVWj7
         hmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772122165; x=1772726965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4UlBcjO6EgElWFbuJfjo44BGajwbLVGVs3YDQi5Dfs=;
        b=s2nyIJpH4+wY0cHDntuxItAr4zR3isgH1Sa29onnvRLr/o5C+2GarvdDNYI7ZEZMT1
         AKBB6EQtZ5wt1oY9oUerTzt/uQSDf6ezTcy1PDayyXsD9dYwWAKoonw1q4491AlzGNm5
         9eLk88igXxbwIrHzf++Gbbt6EnWejTvr+j0xPbux4P+99mDCXNtk7Eulr8rTxVWhFtTj
         aFW6SaE/1Rr9SKXASgDbhgL4mbji7yuTV4iO8GPbtuxLOFM/d5sJTh71SjaDuu+BoU76
         wey5CaHY12GOddXnznOJ7SGQkd62Yd/UT8Pmu49fOSUw14pXdml/k+FsvZ354Ifz674F
         F1lw==
X-Gm-Message-State: AOJu0YxobNk1glEn5iGzaX16dkJ2iYokqe+nxdG02OeNh6iRzRm/Pkk/
	TgiKNesFScQnOgB1nVuv/cYT+bWJMUtw32Y6FwmZKX6YpvU6T8g/EKke
X-Gm-Gg: ATEYQzzvPhPLH4Nt2C6NZV5k3qqfgXeKEPLkOR3CsGx1Dt+1b4X0FyKzqAqEHlG4iLI
	ZDaaUzOiLLfWRdn9UQNpa0n48RoDOuuxD7YzkKdagEcHlTQQLxEVw8/qKBstafOiJTbM3ZFvg38
	YK4+fE+bbrKWxF+5FPbpHlf6HDwedRaJl8MRP7r5XihfIznOh0hRJcS2r+nJFemhpdYILgWIbhJ
	LQOtPJyaJzczhCyJ2BYqhGSXCHvDR3UAHCa0krF03j4n5dw1jcuC9aNl6IaKS7JaeNXS5p1hsvp
	9f4L5LAVq4BglU8r/tXIypMkY7K/YgmxGbGX76sJWU+azjxz7xKw13vIy6+qTxf/zbGfFxW8PcV
	hdiTpQf6GLBPAQiZQt2ZCgL3crjllji8X5RAA5qe5eGWHNezVKr7waDwARAWcdweOW++VHw8W21
	ubDYDVeOqp5tx38e/ryRHUgbd7TajYwdv2V6MFnD9ETzYvUDo+9HTCeR+u4hJmEFy7qOyos3VPm
	nd8+dYNyzhHpiZj7rnadbin
X-Received: by 2002:a05:690c:a96:b0:798:6ee0:2a68 with SMTP id 00721157ae682-79876e65411mr21847417b3.64.1772122165232;
        Thu, 26 Feb 2026 08:09:25 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876cb9f19sm10225967b3.53.2026.02.26.08.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:09:24 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 0/3] ntfs: Bug fixes for attrib.c
Date: Thu, 26 Feb 2026 10:09:03 -0600
Message-ID: <20260226160906.7175-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are three bug fixes found with Smatch.

Ethan Tidmore (3):
  ntfs: Place check before dereference
  ntfs: Add missing error code
  ntfs: Fix possible deadlock

 fs/ntfs/attrib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.53.0

