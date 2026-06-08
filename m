Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32F1B6D1A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896706; cv=none; b=XjmzB5r7fK/bvnlmrIJJvD4paIZ75lZB1YwiyIwUsRw4k229swSklKz2c/waONKrG24yZVlapGY92xlkz2pzbmHnd62/zXjl2ZKvJUai10ljte/CULw6oAuRJZLxRvDdSdV3RuSR44kyho/LkkuZymn/sSfpWAXDY72VeIizFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896706; c=relaxed/simple;
	bh=9ppVgDZ+U7TaJUies9zDuhV2krfxFDCefrzMocA3Pro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkiKsqeTntXTDJnYAIN/8/7VH4jJCSy29tR0YND3Vsy1sjxE38hByGmPJMwMn4tedrUPmF5xV6hV6tTSHkTuuuFd5JoEVvFEHVLuW1jy/a8nzv+KneBZDB9lvW0fvk4ZMw9PEfIkulYs5G3zu6M3/3TOiOseUT6XwevjBJaVcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfHGR0Vv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfHGR0Vv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fd45e596cso1774275f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780896704; x=1781501504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ppVgDZ+U7TaJUies9zDuhV2krfxFDCefrzMocA3Pro=;
        b=BfHGR0VvynO3NRE4POLJpC3e/XGiQ+nhGiO7Txg2LgNGhg0Q4fhNz3Chxpha+KYv/j
         ghV92s6w6RbcNmJQGvE6qzg4qENvR0QGnwqDNFGrvuqxt92ogTKFJMT00FnxO0AZENm0
         w3fMx1t7e1smKHDy/vSFibRTNyprp+SPVb7pgQfDfNjaYHCDCpA+EEd+lM0AvlkSJRTY
         +lUT348cVvGaTCm4IWNJlLsCGBPrI/9OblwegFQiW26PM/nH3zJ0+L4f42ReYj5zyxEY
         rpMI47SSvS2JabmM+lPMEjWMIZqup9FyrzPrrVEsrMcQe0FWrpSZ+Ua+tV/NlerZnelA
         K17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780896704; x=1781501504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ppVgDZ+U7TaJUies9zDuhV2krfxFDCefrzMocA3Pro=;
        b=Q38WrpCidWyqeWWEeOyqWxesRJme8YaCuZQ+AKA6U7cxN78OAhEIELsrXnTKyuVF+l
         sZ2gvx2Ipf9MOgMjlKhyL6yz6/AiEiwQhX5onNfhtMDyNipAGWYODgNfTfsgfqB9cyrp
         a3tc03QHrOHzH+HVpaqFkehRQAPQsxVSw6dYM6iGUJl0Fcquwaq7U6nwq54uZULCuJ2M
         sOfpadv6KVHC/ew821bPkD7ooy5ZN98KLt7tYUEAkK5Px81+1kmIFK7LKhPNavSckQkA
         9JOb5ic8xKq6IXsfO3B+Nnw/uzlQdB6bcdyOzpsnuBfdIQOvZnK5+j0axOIDa7S3FkFR
         t0uw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qfvq3lY8QVWMUVpOMrieHWsfC9SXYsd2UkOiQGe66SBcdA/hP2ZBs0ZOYL0Ffe2T3S/xCyFaNnIG2IKrB@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVSmrqnDnFVDK9mArMtwh23CEhlUC48DP6BUaEvkBlJB5oEfG
	6yo/qtrEuDYAMFpuMOtjIgYtDsPj/XA0SBtqQuRbL9kRZCrVr1ljwGhX
X-Gm-Gg: Acq92OEY6MFU3LZsHalvNIEwdr3vWWgqf596vcl9JGGFn2NYgR5XStA9Ls3ADT7+Qok
	U447NIxq2YhlaLk8/1M6qgrltL46L/Pj4wXpy4Hb7wYwXBfr+IAiLY6Hcu6Ijtln5eoOhUfUVv+
	0V7927o4dw32tmJJOUL+kZTLxFALftTjv6TKp1bWsWAEfGyOyn6A3sxQAR2ekFS684cDNz5FFrm
	ioEOk+UQzLvY1BpC8Sq8ycSusInsRsJIcSecKawFZUOQ73hjuaEHOX8rSdkAn/K9zLUKvMJq9oI
	PQpNXw58cFvhFsObVe1LRD4oHLWu3hNpknROziZO9AixOn8WUN/krArmIN0OjD8tyOEkAxuaNSW
	lrUXkfDs0Rov3QkJKepfXXhaeI0KapGnnwmpsy1eSef9owNTVAf6iqPNmh3OT/COS9ayf1FQ7N/
	LDEqx9aRA4PZGw3qLcTjmIZds3o/nsE/pIS5cbl/R0lKAOX/J+dVFF/HvTOFWk/OExPmzi0Jvb9
	OfFoNxozeMAWoSKvxC2MqjyeP63uDMqjqZKYerVW/QUOeKdnOd6GCaZ4CmgUcrAxYVEXy0i1MC8
	zGO8dJpZdVbmGcsN4jEr
X-Received: by 2002:adf:f5c5:0:b0:460:18cb:8f9e with SMTP id ffacd0b85a97d-460304fec20mr17569371f8f.12.1780896703405;
        Sun, 07 Jun 2026 22:31:43 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm49241280f8f.3.2026.06.07.22.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:31:43 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: security_inode_follow_link: KASAN UAF localization report
Date: Mon,  8 Jun 2026 05:31:25 +0000
Message-ID: <20260608053125.1088564-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I reproduced this issue locally in a QEMU/TCG VM and I can confirm a valid BEFORE signal.

Summary of the local evidence:

- Reproducer started: yes
- KASAN seen: yes
- use-after-free seen: yes
- target function seen: security_inode_follow_link
- target file seen: security/security.c
- Call Trace seen: yes
- RIP seen: yes
- BEFORE validation: true

At this point I am treating this as a localization report, not as a final patch submission.

The trace points to the security_inode_follow_link / link-follow path. I would prefer not to guess the final fix, since I do not yet have a validated AFTER patch for this issue.

I can provide the reproducer evidence and retest any proposed patch if helpful.

Thanks,
David
