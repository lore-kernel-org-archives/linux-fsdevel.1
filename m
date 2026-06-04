Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BF3126DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615526; cv=none; b=RnHbHXawE7LUI4eKcLoEOq+RY0DVdA5ocv6ZoxoDtgkyixbwUMynUyJ1ddI9XFEjKR0TWl5A4LN/VJX9TAvFlUoGfhQDjC7Z4vSlBnBo2OKLbz5x65jggZ8Ip7wRAcpOB9WTzxfIWn2MhHIjXqWSeCVrhtcIBSwYN0CeJLGiOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615526; c=relaxed/simple;
	bh=YcOxrIBH2BpZdGTvyCaML4gFpZ+luYLhgZonf1vLcN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0IteuXMMFjkToWwa7QM+DEulLOnvy6lopDCXcF4me/vMIZ58hfiPM+f9Rr8+BSgskjfiX8TA+W42z3f1H3E2KH0fVmNc5i23LyNoHlYck9IP6dlvLf00Qk8IOJaOgWkEJ3suvVoPonRf21vFN2psTM1B4OAH4vV64K+mfk0u9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8uIh+N/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8uIh+N/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46013161068so640771f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615524; x=1781220324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afznK2o04gyhM0m9icIwY9Iwej89NrlffaDAhI1G0qM=;
        b=g8uIh+N/gdQjwBKnp8QdM9UC7AMhZMoMFU8x1+4Nf1ZixMgj4XYvZIbuX9EqRovwBv
         Xw9+5F+0jLfMHdKAAPFVf3gR1uRH7cCtjue6ZtQEu1m6Qp90KFSqnsD1nfnvo/+epSUf
         UuSmNyxrGH5oghtP9hthV2injV46vu9dbeCW0S7A2wm1e1tpF+EDOGpG9YyVn/mFUV1D
         HgbUH8Jnvhppr4ZA/HqfrYbMCP2zQdbv8w+0wuBgort9e/YSfdtShgpq6FiaxmaaAwVI
         fm8QHsDDQb/4bNz2RtQ9KCmqj2lg2xxygCSqX83y4EeI9SzIg1haUi1zhbfPFczjBEBk
         D4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615524; x=1781220324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=afznK2o04gyhM0m9icIwY9Iwej89NrlffaDAhI1G0qM=;
        b=QKj7/br/JCtpSINEW4U3c1oTPc1cZmyG4Vw5Rtc3r/mQwgGILZrG6JxZs0LUA8cRQx
         dqBelslL/84Ok+FKcE1D/LVdM5uD4RFqCqeBGnw23/7j7gal/rQGmKwZACX/DfUj+ImK
         s2xw5+p3Y4Q6wmvFYGWZKni8LmicYtUsHCcqkELszaEShojX0vIbnOG1qc+A4E6czXe0
         kq+EhsoX5u99XahExRUg1V/Hn/s8w2M5+W24XyXw2aMT55DF1DNHadlSX7bO7GnBwijG
         R30erSf5fdEjdjsLEORfpXsU8hk35xaYrYMgoDrL1si8sNci0s+7+ABysU+4LkmY800g
         8KlA==
X-Forwarded-Encrypted: i=1; AFNElJ/wuirVi9eMcm4UEnTHFqOAG/1T15BYLoE+JUwqMrRTFWEh8NNV6M+BOmXdS9+T4qoHD0bSzI6YByaIdtx6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfn/uyLqZdbCqbgRg28RRyApIDkInKpesIN8xMtfwkuK31yb57
	p9950r2Do+TqQ2ofzlwJuGjbWH6K/qVRr6g5dlZZLmHJdVa3jbtHjNY8
X-Gm-Gg: Acq92OGgsyGQhcpibV+srwJmR+4hzaenQNIHP73ipGeYfHd2v3M34ASJLOAE9/aAbFG
	cS6DzwpMwuSzAj0IGGgeuXmSDqT+xCphpzQ1yhoE3TWXK4XdO20luSy+9t7k8eYfnYtRwBl5YvY
	IWvRB6lw+8T3apDZnzIuW7lfREeXd4AJ+M3h4YLyZpW94/h4LnErtIOEt1BjXGp4geu1SfHLUqw
	nnu4dGSrBEN6kPoxmA0dGRXQ0+2CL9KMUjN1LMtlV/i0sZy0gVlkisERwNEkyOfFb7ubORCBRX8
	A+0UOcFTfFmeWuSKfr3vPbrzlFYCUd/VbL7v8PS96DBvcGL7TMRFHsyOiEaW65mKeFsqqMPLUtr
	0CNeU637FDYJcxjXy14mupCBmqSKZgedxkzd/eh92jIqeTkS50FOAeJIjpeNvUCaRz1bCXRsa/X
	Y0qCGw/fJRjqOcNYmVppyuWNFj5xOlWA==
X-Received: by 2002:a5d:4e49:0:b0:460:1ab4:6623 with SMTP id ffacd0b85a97d-460306429a0mr1128044f8f.27.1780615523601;
        Thu, 04 Jun 2026 16:25:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f3529e0sm20375107f8f.28.2026.06.04.16.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 16:25:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: david.laight.linux@gmail.com
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
	metze@samba.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Fri,  5 Jun 2026 02:25:18 +0300
Message-ID: <20260604232518.1896014-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604183829.63c35fd9@pumpkin>
References: <20260604183829.63c35fd9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

David Laight <david.laight.linux@gmail.com>:
> I know it has mattered elsewhere, and is easy to get wrong because
> 'mostly it works'.

I will send a patch, which will change that argument back to "int".
Hopefully today.
Also I will add that "wait_for_space".

-- 
Askar Safin
