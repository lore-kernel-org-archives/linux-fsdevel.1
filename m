Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01542E888A
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359768; cv=none; b=JK4+Syqyfm7lJHavHnkrx/sH5HGtcoUvgr91sGEiIekIYtRRA74NNATINkPbuQn1rliqj1qlaqV4kaMAfY4K3wTlLv5nJixOF/3Pp3xdtIOEiW+DxgoaCQv/0KmxzSxoBGdRrfNrSBD0r3ocWMBCQhpCeCRu98Zrcdv0dsBYF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359768; c=relaxed/simple;
	bh=i0aRAUFtI7aqAzKD4q0jr5L562kAcIUmoKjS1lDhZP8=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=VTZ+heRLQ7/nJs4avFsCFNrTIT6SNJSzi67ax4RkcaOPwJX6K5Iju/6XJxnfLaqCdj1GUoxLuaO8DlPD2pxf9q9RUdEh1xJSvVTFexgPjda6wEu7pAy9zWvmRjkT3KDJimy23TVdoWzVWNHIKhkt1eVSuMmQlbMqWwCa4L20iDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNwD1ur9; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNwD1ur9"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bf854d5feso4346335eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782359766; x=1782964566; darn=vger.kernel.org;
        h=content-transfer-encoding:to:cc:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srhS5i90p9Ok5lxqwOHZkSzHn+Lf7VA0N+H4FT65HJA=;
        b=tNwD1ur9T6rnXrFI83rv1VscADTwkgnGzWd3/8cXowET8MB7CWONP9LD8A1tY0SRrY
         0EmYh2+rrXPC+ozviEK86lZvkL1Ur9WahRbH4RzjcJgLj3LhrOFqMznBQ4vpU5QNT2jb
         oo+qFNzdsNXY3xQot7qGYa5aBYb2iLlmD+YpHbY/ch8gWEp8rrsrx/6pC/PcVKB0Gs1/
         E4UvohwcSm00Zugh6iQO3yBuzJWcnrI2oNbEXIA8vb+ttIucKGc2bjektnJWj1IAs7La
         AQB+ndJ7ShypndIVKhEx1nRanzRy5+2XZupX5GjytTV7PmRkzT6PCLtvrikUWPUxCKtx
         GNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782359766; x=1782964566;
        h=content-transfer-encoding:to:cc:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srhS5i90p9Ok5lxqwOHZkSzHn+Lf7VA0N+H4FT65HJA=;
        b=A58s2rAjL4reOYHJaAicJldK+6YOTiH1YIgUbplanb2HR2NgNapcCtQigiP/ygs2iu
         Yh3toI/pIe5ohKJc6A+ruEfUNH6rdFllpL0vVZbKhidCpeYkPTv7Eh+XRhITDnr+lBxR
         Qu80qcCp5V0aT4I5gTx5NqHXZjSioIxd0Zat5PkN8Xfho2RNdaMUkgJERuEVNURtiVW7
         Oox/nP1gUu0c8MNB99H1nfM4YVfSlP24lLgkgaM4QlhuTOJ2R3MuXPaXLWaTLzm+DXrY
         rMCHyBxZsoz9zhQujwXBHPUMWtM3vlvf3wrmZvfj9vUKwN76YQUBRk7KSHTxztT5sG8b
         phlg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4r+Pu1DEQ5RdNpx43hp/fa/LwbOjaHdJVUsq2VFzKo6XPopFCNRvCHzIBZqN2uqBg/dHxKq9xHbGMP2Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YzIV1DAKwSJApFKsTCrteWXskpFgUX+mbnFIMvrz6+aEF8HgcVr
	SCLg1qSY9qxqn39Qh8C/WaBqqB7GUeIJSAirBPqGRSDyCcFl7dD9l7UZ
X-Gm-Gg: AfdE7clUn4e1YQ1RCLxXHq+k3vYhzYZIMqaP/tKkqYiNBcVPTZkS4lWtDeaE/aat9v0
	nd2tdcvyx1KxMG4nahwUBQjML+tovOjj/fYwMFKrFq4LWXnFQIUpIdQuntRhBTu+w38QSKYXUIR
	+L5y46aZdryKEf6H6ZCT48HVjptNcx+w20D/h5VDvzaf9WfOMIZCaY0odP3ZBc9Usb20BLHSdiU
	vZ8dHy8D71XMMBN/9g5o9ZQZGKEk1/1Sd5FN16hPCIyUCdTsxA7hj/L9SzGAFJDZoEuOkcJkFcd
	xj+WqOWc5dp40NnU6Ta47XWEcQXgzTWrJEwEsP1/5C+dgx239cwOqui92ZIlhjEGtkHF9IQHa5N
	u26jnk7iErKbyI88KaXfK1nQt1XgAX5JvSKEjL70lfRG45beHFUvoNAVTr83OkBjA+ofSGgovxb
	OfJSjEL/byEtNCavN4VqNgCB2PuQ==
X-Received: by 2002:a05:7300:23cb:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30c84dfad18mr1166720eec.23.1782359765690;
        Wed, 24 Jun 2026 20:56:05 -0700 (PDT)
Received: from [192.168.0.142] ([49.207.145.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm3867938eec.8.2026.06.24.20.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 20:56:05 -0700 (PDT)
Message-ID: <7959ba0b-c39d-4cb3-8269-482d1d593257@gmail.com>
Date: Thu, 25 Jun 2026 09:25:58 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@gmail.com>
Subject: [ANNOUNCE/CFP] Linux Plumbers 2026 Containers and Checkpoint/Restore
 Microconference
Cc: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Mike Rapoport <mike.rapoport@gmail.com>,
 Christian Brauner <christian@brauner.io>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Adrian Reber <adrian@lisas.de>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>
To: cgroups@vger.kernel.org, containers@lists.linux.dev, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-integrity@vger.kernel.org, criu@lists.linux.dev,
 lxc-devel@lists.linuxcontainers.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

We are pleased to announce the Call for Proposals for the Containers and
Checkpoint/Restore Microconference[0] at Linux Plumbers Conference 2026,
taking place in Prague, Czechia, from October 5 to 7, 2026.

This microconference will focus on current work and open problems in
containers, checkpoint/restore, kernel interfaces, and related userspace
tooling. We hope to bring together people working on container
runtimes, CRIU, init systems, distributions, orchestration systems, and
the kernel interfaces that make these pieces work together.

Topics of interest include, but are not limited to:

  - New VFS and syscall interfaces relevant to containers, including
    work around idmapped mounts

  - Closing remaining gaps between cgroup v1 and cgroup v2, and making
    migration easier

  - The growing role of eBPF in container runtimes, observability,
    policy enforcement, and checkpoint/restore

  - Mechanisms for mediating and intercepting increasingly complex
    system calls

  - Lowering the barriers to practical use of user namespaces

  - Attestation, measurement, and other approaches to establishing
    container integrity

  - Better resource-control interfaces and limits for containerized
    workloads

  - Keeping CRIU working smoothly on modern Linux distributions

  - Checkpoint/restore support for GPUs and similar accelerators

  - Restoring FUSE daemons and related userspace services

  - Handling restartable sequences correctly during checkpoint and
    restore

  - Support for newly added kernel features and interfaces

  - Shadow stack support on x86 and arm64

  - Support for madvise(MADV_GUARD_INSTALL) and mseal()

  - pidfd-based checkpoint/restore, including process-exit information

We are also interested in additional topics that may emerge as work
evolves over the coming months. Ongoing development work, operational
experience, unresolved kernel API questions, and cross-project
coordination topics are all welcome.

We encourage you to bring open questions, unresolved issues, or problems
that would benefit from input from others. In your proposal, please
include a short description of the topic, what you would like to
discuss, and what kind of feedback or collaboration would help move the
work forward.

Allocated time per session is expected to be between 15 and 30 minutes.

Please submit proposals through the LPC 2026 abstracts page by August 7:

        https://lpc.events/event/20/abstracts/

Linux Plumbers Conference 2026 will be a hybrid event. While in-person
presentation is preferred to help keep the sessions smooth and
interactive, remote presentation will also be available.

We are looking forward to your proposals and to seeing you in Prague.

[0] https://lpc.events/event/20/contributions/2332/

Thanks,
Containers & Checkpoint/Restart Microconference Team
