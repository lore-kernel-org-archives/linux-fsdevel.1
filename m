Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374977;
	b=HQ9hpepbiq36YLRG/tkK1RYDR5GNNH8b0WcM2M7E8dbwhckXDr5whNugyVwoEXKR+MfU
	 xxZ7+ngO74hwRqQmmAjybEfcfuuqVPkQWHsAsOXA1AD2iJJyNoMECgRqGT3nj98sY/5yR
	 tgVyEQHy78iwgXCqVe6QmvgpHP9HqJhiUM6v77BNSLBfxFvRts9Zw5uLxtQnlp0YlNtWA
	 EQqUkP2cYYbTPZrxIGNaIRv5gRgEKVQsem6ZO8bfyUKNcL5mcsNkOYjm2013QWKeNb0sW
	 K84LhBQ4j7+2BZ26DqIno/HuIn6wRSNQK3E3OObxo9hsdFIZjJua8yEbkbVXeTdn2pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374977;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MA2TLhf9GIq+1H9MDWnfSDegHGqUqQSVqLgzWx6KKgI=;
	b=bsI0PyeZ8zXK3sPoxkDw+ITiekqMLJT252Xa4XxvTa21aylcmbISTpnXJ9C/hwAsO1+k
	 /rOR4Oy+8ZwuGw3PuF9TlSSrdT0p4ZTjjx88gzgAo7lp1pnDk/ARqAr/PbgFATbkD5Phr
	 jVGoN+U6DLsSaYQj6gStMqq+M+2V49OJljiXypilakQ7tR6j9ccjNB9NfaRJSsH3TSrlG
	 qQvYPQKjEYJ4LdIHGagp6Y8GmZc9bAjPywzd796joiHoNscdDHcUpBd71umWgTDALkGq2
	 26JikiYOPh+WFPUZf1TcrjOxWKCwLYX1oW3U/Ytm8BugCRk/RhJGcm5Zji/wtZWA25w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwxiOWf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045A606A32C;
	Fri, 30 Oct 2026 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwxiOWf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3831F000C1;
	Fri, 30 Oct 2026 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793374977;
	bh=MA2TLhf9GIq+1H9MDWnfSDegHGqUqQSVqLgzWx6KKgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HwxiOWf7U7ryeQuojPPbzKdeL/kxdfMWjOAbrwECllhxuwDQ35ItUDORWEjM2C0nK
	 B6RoX8KaIKb/856T5qsQdkIyt8314fqs27n/JfrBnRyv7PjNZiXuSxWF+j5y0ae2t+
	 6UXtDIw0q6LS6Ixa0gJVTRIlgnUc1zqz7DYj5K4nmx9vVn/EuFQ7mK1SzaWBdY3clu
	 8I3w3sBoNLxmPwUpOkPqcS2tNbF6PE+rZHVFCDTyedWSd6Vg8e5xVSwfefisk0Quz8
	 rK8gBiCnyjX24ftimZTtevL/1CT/bmDj1oBI9Ave2noMPkMHUcV8aC+RJgC+loRE0o
	 EkmjCbQu7M4XA==
Date: Fri, 30 Oct 2026 16:42:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: shuah@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/empty_mntns: fix header conflicts and
 remove TOOLS_INCLUDES
Message-ID: <20261030-vibrieren-raubzug-metall-d4a1287d2fc3@brauner>
References: <20261001065728.90239-1-disgoel@linux.ibm.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001065728.90239-1-disgoel@linux.ibm.com>

On Thu, Oct 01, 2026 at 12:27:27PM +0530, Disha Goel wrote:
> Including <linux/mount.h> alongside <sys/mount.h> in empty_mntns test
> files leads to compilation errors with glibc due to conflicting enum
> definitions of MS_RDONLY and other mount flags.

That part is fine. Note that ../wrappers.h still pulls in
<linux/mount.h>, so what actually fixes this is that <sys/mount.h> now
comes first.

> Additionally, passing $(TOOLS_INCLUDES) (-isystem tools/include/uapi)
> causes tools/include/uapi/linux/types.h to be included, forcing
> int-ll64.h definitions on architectures like PowerPC (ppc64le) that
> use int-l64.h, resulting in type collisions with system headers.

> - Removing $(TOOLS_INCLUDES) from the Makefile since standard UAPI
>   headers are already supplied via $(KHDR_INCLUDES).

No, please drop this hunk. $(TOOLS_INCLUDES) is there so the tests build
without a headers_install and filesystems/statmount, pidfd and
namespaces use it the same way. The int-ll64.h vs int-l64.h clash you
hit is in tools/include/uapi/linux/types.h and only shows up when the
kernel headers aren't installed. Fix it there, not by dropping the
include path in one directory.
