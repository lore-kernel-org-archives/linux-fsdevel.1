Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD53DA5B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692454; cv=none; b=niUU+pMpMXu1/ROjBE0NxxVMInVDoiQ3r6iBX8OANXX/ldNk+gh4vZJdv9V18s5CBrTyAcyzW928cYLorpzrGaxaThuaImXUu0lZLoJu9euHnSBwQlHhyVLxxMh1bGENKgJoe3tCciG9hvxOqT0P0Td4amp/Pt+MGzKsEwsbTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692454; c=relaxed/simple;
	bh=I2DW5EifHL/CwybK99JpVGsFZTmrr37j3nFaVNf5wZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lZ9xwMP64AKcPf8sJXFiQHKAthUoEExgSMRauMhuQOkQaKHyYis4yWUb9a66OACzwyCh21AJ1kciZrqCpE1QjNUR+D5VrdF4L4RYjdWXkCH7bVgx2qwcTlE0WJv/bdMLphhktxNZcS/JOTeWBZlhJlHuzLsGGSYXE27uO+qPm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=taZUXCPn; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taZUXCPn"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6c166bafcso4580235ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787692451; x=1788297251; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5G2PRR2+LR4ebaBcqpexseLcg7M12gYjA5TXVATa8Mc=;
        b=taZUXCPnQJYFwvUv1PqjUTCSDCwClCssqSnnmFfNi+Vr98ra7xjHYh+2gLAZ+gGcjZ
         CioZnzq8WkzAv5TGBCQeOS93Iy3M2l/AS1E+LKP3d8D9zliNy8lB+1uXHNn0LVFImSXz
         qkuBhCRpNc8TO9BgpygsIFMRncOYnAkMWJd4ppilsiachRT5Tv6OZzaBkiKEdkOO6cRu
         DU+YMZv0wpz6/F/oAXLoMLuijaOYkCZTnQ3CaQC82SRzFbB8imK7nIWN4W3VscBzll28
         R4bz24PvJFh14osgIlfDkXIZIlwk0ToFuha1O2sjy6dfkNY+Z/TGhfOqHPmknPT9O/RF
         ZJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787692451; x=1788297251;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5G2PRR2+LR4ebaBcqpexseLcg7M12gYjA5TXVATa8Mc=;
        b=pXmAJKEUSSSJLFog8bms0jkMSoHAD5od/ivkNWVPLFBL9l8Wd8wJYaBOi3L2KdhhI6
         ou9+qLdyg7p/X47syFCqrSian01ius7BHec8WjaiRUTCcQ6Y3BFDl55MhDlH6X0XR5PN
         I94QXC9nagrvGIkKvZNAej9Myk7jXOw8hiHQowoDQkTGus3Ral26rg9DUa2yNFDCIAgQ
         J5r5ffDIotBwLGNs//sJBch4VEjXV7bf6pUGlrUCOrOYq5w949qMicC7IKLzy8XTyb4p
         lGOwuLxlrDyKORMYsIwlTDUlNDrBstxIKWEnVfhc+5oIdahHIl357K/58W+5MGMMXcci
         iycw==
X-Forwarded-Encrypted: i=1; AHgh+RqNljnnBkl6/mqtgcFBXxKfhKYdpBlHaltNCmWQELtvdnCfQw5pVNouQweq8JF7m9aUrUnWLrf9c2Osd2Z3@vger.kernel.org
X-Gm-Message-State: AFuF++k9Ry/DJVZRe52Bt3WAeePMv1lqBeOK03QMVVbJGlSssHynEn87
	Zj7gBQROUn8qOtFUNETql77Ahs7R7HMB8d2wUGD+X4HSZgRHIMThWCyemLBZjIon6BKe1LLpjba
	CvfXdXvG9Qw==
X-Received: from plhk3.prod.google.com ([2002:a17:902:d583:b0:2d3:a560:c1f7])
 (user=psalian job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ce:b0:2d6:f6ba:263d
 with SMTP id d9443c01a7336-2d707aafd1fmr20811815ad.7.1787692450793; Tue, 25
 Aug 2026 14:14:10 -0700 (PDT)
Date: Tue, 25 Aug 2026 21:14:10 +0000
In-Reply-To: <a877fa95-4cb4-44b9-b123-5d9084fa4e65@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <a877fa95-4cb4-44b9-b123-5d9084fa4e65@amd.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260825211410.2805027-1-psalian@google.com>
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
From: Punit Salian <psalian@google.com>
To: pankaj.gupta@amd.com
Cc: michael.roth@amd.com, thomas.lendacky@amd.com, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stefanha@redhat.com, vgoyal@redhat.com, linux-coco@lists.linux.dev, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pankaj,

Thanks for looking into this! Yes, that makes sense - virtio-fs DAX support 
(the DAX window BAR) was developed in out-of-tree QEMU development branches 
(e.g., https://github.com/rhvgoyal/qemu or https://gitlab.com/virtio-fs/qemu) 
and was never fully merged into upstream mainline QEMU.

In our case, we validated the guest kernel DAX driver on AMD SEV-SNP and Intel TDX 
hardware using our in-house lightweight VMM coupled with the standalone Rust virtiofsd 
daemon. Other public VMMs like Cloud-Hypervisor [1] and crosvm [2] also support 
the DAX shared memory window natively.

I have posted a [PATCH v2] to the list incorporating your Acked-by tag.

Thanks again for the review and assistance!

[1] https://github.com/cloud-hypervisor/cloud-hypervisor
[2] https://github.com/google/crosvm

Best regards,
Punit
