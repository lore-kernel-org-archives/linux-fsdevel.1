Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937763CCFBD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441669; cv=none; b=o12Fl1T4g/1O2RJ9Kf3f+mpAq6qoITOwrDG80+7yVKC/4D9cSioOjAEJ6qyQvDb/FXknArhkAef8FXli0/PaPIhh/E74kUXvVciJuBYVYZ0zQbY4PCEPckimIy7WQz7D8G4TciyWLpuKPehPWgubA8G/ZVXNVf/P4fh/XW8JtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441669; c=relaxed/simple;
	bh=5chq1ZYL6r9BXlem4E1EUr+5R5J1k5Q21LCWXDRISUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCC1hOjqG+o756LTgjvfhjidXKpoK3F+uHJ0RqRPS/0nNySufaMSxksNj0pBiqwX2hqCn4uTQTQA68xKMP/sMc8hdpMO2ehrkd+PjtJJKhu7ltSe8KwnbL3ldE3Rdk+0rz7MUj5cq04qGsjsPTPM0bwrNtZ/2etcN/uvlTcAmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0Qeljjj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Qeljjj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so5306195e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780441667; x=1781046467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvSaS68IPr55Kp5FHpvrg0n0LohiEL0S8pivrepEpA4=;
        b=g0QeljjjZVRfch0Tv562TmOzSOJBhL8ujFnNlpdXl0x1fHoxAC80hk5vUbqtI6keb5
         dN6GvIY+/6KPLAPt+nptAK3fOIQGMUpyiPeAvndNg/+gozsMl1uKdb38DDTdyjz2CKsf
         P1W6WDQZF1/0B1qBjQ30EqXE7aq0QK9VRgE1FpZeLD09Et0PvqXZGbFjWX/f7K8PBxMZ
         EIMxvsA1XP0bqYi8v7JJpcE8boyJ7SburJV5nC8F1mvObatl+7o9H2Vgt4QQvh86SU5+
         7JLkm69aetHtPhoqjFK62BEHOIb1aItevXjVcnkfBNLI1pVeaxZ2ImvNnqLeOl+s6fnr
         KYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780441667; x=1781046467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvSaS68IPr55Kp5FHpvrg0n0LohiEL0S8pivrepEpA4=;
        b=Zj5s5rgSIdLVa3HjlN2sFpeCwqlgp87Aq2UKNnhDcQ9TVgKQMdYCE79glGj3H0iC78
         3dPxxx5hq6rR7Pf1yz/e7P8LYJWgoHDCTO8V6P5rNc0h0SFzze+iK6FJf0zAL9MXyQYR
         UBW8alWRzARb32kFL95Y2zAs+NHaOBT+QK1lWLQI2xbsypAMJvNDcGHNQMDC0X2l4wK1
         6iEa1fM3kZoRzfy5SBphhlVd//ydcDzjXzJzzGskWX/SXCAurByFOCweul4OE7ET4m48
         MEiAPAPcrzG6MLOuO6khA10rp2Oy/NhMutIDfbVv1i9cRuUiLPwUGjlacfr7NNeae3za
         ygLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yDvkrckv2qnpXjghVuChhoH/lTFMDPxBPPhbXyS6ngHcf+KruBR7ofr7vk8TnH/OQ4uuD6NIJknJM6HgK@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkQYdmetAYn4nnbfbAtepnMx5Yu+eY7VvTej8EdKd4fo/0HGQ
	w0YI5cUXDzyavWbwBLJ6WrXudnp0/kn77m/EOmMLoIce3/o8u8WFZhSR
X-Gm-Gg: Acq92OFXNs7tyry88WfP6TMU+GBd3AhwTLyHOPS8tLycO30gSeA/bSViMGaKo42w+xz
	+Z2bOZSaxHPvcXeZHkN23HrTLbnKPk3OOHKpPoWrK6AjdaNpZVYveXfKYZBYVMb4LGvSae9vnKd
	1/1HSbrYLDP7skSAwLcIFwZs33j3+BQP7ZpKZUlGz7IBzfrNN4bPXikjC916F6lFAnQMRYVaxYg
	omLF1Y/U7T2V+bw+14zt7HHQZn18vM/UusYu12OIBFDvyTykJstrR39Exmt2fkFc4mBeDCqIcaf
	4FqBsbJPPf8utgKJFUXUVK9QeWkZKGrftCrl1v7jNjYwJgttqeVfmU57nT8oSPIFkbka89a90I7
	iS8CcYRZyAtQE7PBWM5/wvJ324ctvHRUxcjbf/c+HF46F9mPAn3XmrVF986m6izD7AiE7+xr/2/
	1v9AGEV5aQ4mNNBnframgODA80Vb01a2CQGI8vS8BH
X-Received: by 2002:a05:600c:698c:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490b60fdd10mr11320095e9.30.1780441666946;
        Tue, 02 Jun 2026 16:07:46 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7a71bb7sm357295e9.10.2026.06.02.16.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 16:07:46 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 02:07:30 +0300
Message-ID: <20260602230730.138904-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ah9Yle5pd6mD9Ugr@pedro-suse.lan>
References: <ah9Yle5pd6mD9Ugr@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pedro Falcato <pfalcato@suse.de>:
> (Askar, if I was too hostile, I do sincerely apologize.)

You did nothing wrong.

-- 
Askar Safin
