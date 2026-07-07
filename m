Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC6303A35;
	Tue,  7 Jul 2026 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423388; cv=none; b=G2wvyM6tg6/D/xsjWQzx8U6aIJ6LfHTxE6dgS8GCqBHxx1rZS4AnbAfYXmpxp2ztvOx578K0M2PiYcnDwyo58603OAIJRy3rRZC0xexv5fZEGR/8LJMBnCijcdoCi7y4mO0VZFOgrz6MLAc7C42IcTucNm4CilSvn+VoyjhNOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423388; c=relaxed/simple;
	bh=pOS1DBjTiGsMjMY0jt0SNGg541Ers7gyWHbpeFfD1Cw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tpb0XoCeT5viZdNcFJHqxoKz6W77plVE8oytX5d9PGBOCGfFR7hvDfRE4kirBC0im/6TB/2yY2zC/3Cqcl4l8zAvj2iYRWnQDpBDPllli1X7dwh/KxltixpfBwTp126qHYduPbPk9ar5Bgo7EWDjM9A4RtZa4lDSwBcblKaA2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPsZu7t3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPsZu7t3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A341F000E9;
	Tue,  7 Jul 2026 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423386;
	bh=VGMEcV3Oc2li5QVYZHUZ3eC2NQvwavPm9nW9Zo8pKVM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VPsZu7t3rNi83aISUDXW1PP1nYIpeaD/C30aMHzRdcNx41FI8VKd/a8hkDwN7wXU2
	 4Ppn8qEUCUYQL55ETJ5K12gyEfqY8vzAAYPt6RCgpw8eq6C1WF0qaa93SOICj5NEhZ
	 HhIWiYhVxWE6gByITeQohpVuOrXSdYQALN6m7MT5JVbAjT7uJ/brQWDxhmJe3lpN9U
	 IJHKmFwo8UH3NC1HoVo8qjnuEkh4/YeVCe4wCoM3d3xjTOzwI/66XTJqMvVLIa4P2M
	 TcOq/6olQ3QChErV1xmf0vty0SHvHU5iWVHjzzmeoWxGxUAatMVYMcGiqOX9Mxx0rr
	 YM4C+kjLlTreQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
From: Christian Brauner <brauner@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
In-Reply-To: <20260703122548.1623981-2-rrobaina@redhat.com>
References: <20260703122548.1623981-2-rrobaina@redhat.com>
Date: Tue, 07 Jul 2026 13:23:02 +0200
Message-Id: <20260707-sippenhaft-teufel-bergbahn-87d9652bea7f@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pOS1DBjTiGsMjMY0jt0SNGg541Ers7gyWHbpeFfD1Cw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5PJzhEL+p4q3lwV/xh/zXrmTl1n+Y8dXhhIf7Op4mv
 Ve+XCItHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpncPIcGiSDpvLm+XKjCpp
 by4UaQk/eyS6duP0rYdiU//FeXpcP8PwT89vWn2+6cxNH+s8xVSvyuWk9lokvp3fuPq57tNTM0u
 iOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the fsopen syscall but
> does not capture the filesystem name string, creating an audit gap for
> filesystem mount operations.
> 
> Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> name string passed to fsopen(2).
> 
>   type=SYSCALL ... : arch=x86_64 syscall=fsopen ... a1=FSOPEN_CLOEXEC
>   type=FSOPEN  ... : fs_name="tmpfs"
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

I need a hint from the audit people whether this is ok or not...

-- 
Christian Brauner <brauner@kernel.org>
