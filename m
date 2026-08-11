Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18143C7C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445373; cv=none; b=d/o1ZUZYDP5q/rUh/yOEz1FtdjjwefIPpSBHbeeHHoz9NG1SiPevwa7oTwFUbYXCJ3E7WCWM/OPEnqCpY84Jb7G4H+5B45WXaDfzSLD2i4/f68FJfLihIqr+nZlZN8IbpwuS/i7/M8mtt1fFiWAoG4aGGArKrVQ6gbur1cqMXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445373; c=relaxed/simple;
	bh=ghS+Q8ddKbWmypXRks4ACpl90kL3VTsYQSivB8z4dzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgD3t9csLLOvHZ0rcrBQfiQ7+FSoC9qWMvBRrIu2xP4mZUcJHE6qGoFXWT2LIY4KE8CRQRnner/kFxavEDiVr296jt+VAUf6PJHDkYrS3yEUBfGelWx9lQPAniSI7ex4myCC7byUwQ+OPIarGF0tvUEv/dqb8o6McnyPQ8D+p6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQTER56P; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQTER56P"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883fbfso1046660a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786445368; x=1787050168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ghS+Q8ddKbWmypXRks4ACpl90kL3VTsYQSivB8z4dzM=;
        b=fQTER56Pu3UMA1VJgujKwNm4EKFjuFlf6tjrcPMofvyGZEmw2qHQWKuJTt1X8HzMAy
         MlGsjt7vfjMWngXWbnEb1TyzSZ9abJ4sY/KX1cvCDqFf7+wE9+kX0LH1Y25ODgqVmFQO
         pgjKTPjPeeWNWqj0sI/OUP6WtN9TmniOktSKoD5Q8zbb2g7EdmW9KwZtgmKbAAhx5lyb
         DhdXDci+8BEruhHVhlRfjS9zYd9CT946LLuzi1+tzp0MF7Pt9jP3KFCgxOkgLNSC43PH
         pBaNfHNe93Q3kaM1+eIFT9AIWNPDLHWd4UAnZe+4J8cC03WTRd0siid+DHnGY6s28L7S
         8Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445368; x=1787050168;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghS+Q8ddKbWmypXRks4ACpl90kL3VTsYQSivB8z4dzM=;
        b=oHwcMXI9GdygWjTDfNU/QzDtwsRM7jo1hgZgL3gIuysfV5DWbSTycl7bMuyrK8E+up
         L+1Z1q+8ID7irBQE6E6Nj8ytYYC+U3g27SxglZ0vvVJiLOFNxMWfN8Er1hoBYyyDz7mc
         uc9QRpiWzMgI4wJkXLKHCge4583dtUDiSO3QAHVrGo/dstTq5S/LdrYx96PFCv9p8MWl
         /7uCg+IRc2HR/cdEP6AqwkIglcmRzZvwK+qSEMZZ9PQrqftq+nPGAZXLhjR8AeEImZe7
         CbrAkIa0Nz9mGymfJcACvO4m7HYXHhnKbBW0e6Qmo8ZPjk5D/Dct0cuMy0irTKjlDnu6
         J0Mg==
X-Gm-Message-State: AOJu0YzmG4PagxKf1VEVSSxSJaon98dxPdaNd5Z8nDpd9b6FLLHekSbT
	HUjgMIKhUVqlbEsKF6L2PKGJa5pYtMheew8mIUMDpgJN00FaaMSA9c86
X-Gm-Gg: AR+sD11mVL8TU0JZSNfgJG6gTSb++FkGZkujnHjSoF5vu5YJJG111oZdeYFV5fFuJGl
	UYirBsNUEGG8VPPznsDJQojowsAzLPFjHvXZBbrBQVtAjqaw5qrNvo+sHNCE/trNGRqPj7nbCBz
	wVCA9OUp1vKj4Qc0CRLuKL4WTwbTtQBY9/3QSY0NB3Dzrkdr929y0e2O6E62ExoSOI8UzpIRt+3
	X+W6Cos56WNBQWmtj2OuVWQ5ITlrUC4uKz7WLkiz+UuruT611CC+I4TiVUK8NyNslBWTStSJULb
	UuAi9hfwdqJZAP5EcIihxzcELkB+fJGduYWJU4i383xsMZueZZjHFEEUBpsvXtuKWnotzUIN1w9
	XPUmeIc5s8MOWIZUZ+Lsg2N8LAwf51WlK8mFBXfxA8MM+e3//Xxwv5T1a14Rq48m7UcKdh0F/IJ
	yOloMKIqrodzFtxpPB4tbm1XL/GxBNxjP4UOZBo3J1vG0U4y1krV0UjUw5xQQJ+CLTv0ul954X7
	N6L7tVScKOf9pE8WA==
X-Received: by 2002:a17:90b:3143:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-392ec747b05mr2307488a91.20.1786445368003;
        Tue, 11 Aug 2026 03:49:28 -0700 (PDT)
Received: from xiaomip5p-elish-armbian.. ([2408:8220:6b4b:bb0:3bc5:a2cf:f997:7a80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51e3467sm3436132a91.8.2026.08.11.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:49:27 -0700 (PDT)
From: Gu Lingguang <liu83783@gmail.com>
To: Alexey Gladkov <legion@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	containers@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Gu Lingguang <liu83783@gmail.com>
Subject: Re: [RFC] mnt_already_visible(): should regular-file mountpoints participate in the visibility check?
Date: Tue, 11 Aug 2026 18:49:21 +0800
Message-ID: <20260811104921.8099-1-liu83783@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811-obsession-propeller-eiskalt-a2ca8b0a1017@brauner>
References: <20260811-obsession-propeller-eiskalt-a2ca8b0a1017@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks to both of you for the replies.

@legion: The /proc/keys and /proc/interrupts case you raised is one
I missed, and it shows that a new mount can grant access that the
container's creators do not want to grant. I withdraw the suggestion.

@Brauner: you're right, and I apologize for the length. I'll keep
future questions to the bare minimum.

Thanks,
Gu Lingguang
