Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163B2EC0BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010074; cv=none; b=YjIxzCrG9TmtDS1vKEl2WwNiwkA4TuStd6wF3iPm6TuWgqa7BNxA4Mo/85yQtCuiV0YSm75m01tKbolNOARzvuVd7gADowZtYNwM5CT43CAUNg1XTGqib/Tvt0y241QCPSMFLe7WeYJqCaQDG0B/0DSrEirH4+RfuDe5eur3uMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010074; c=relaxed/simple;
	bh=URqDCRSR+b+1iPU726V/Ba0N5sOVMwxoTULga1+H90I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV71//6fsd5TFsvuiKQy46Cu2e7x5q+geFoGj3kVy0AQIX2uezi5MF8TsG9cHqF5rGrKtpNeYMrf+/WOvvTUlikFucbRxukZOYqzt8sRWPCrBV8O1EdYe/QGz6989fC7kxpbx8Hk/ETwgwPW6vvXD94tV1w7OwIWYOqzMPnWIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKBgehiC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKBgehiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F244C4CEF7;
	Fri, 20 Mar 2026 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774010074;
	bh=URqDCRSR+b+1iPU726V/Ba0N5sOVMwxoTULga1+H90I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKBgehiCIXRG6KvQcLwtsAAUm/xPZcPlLoDS2QqVtZO8K8EUSYV6pZ48LC1ZMxy+O
	 7ds9Keeg9C5MVEsKnN/847ed71QohiM1T2X2bAunsyIlz9FzZ0icmMUQR90bCIBczW
	 qGhZqLpgkrx/64/JnNXJiyFywKY8wbIS0A27Ax+8YtojjmsurcT/4UuOr9OMihPlIX
	 8/H7LpJvmSHtLNBFz5lkPYp6qTPAmjjmuT3jubyo8L95W6+XIWQ1v6KDXvCM8Bliqi
	 dCHmv2KMxTSCIv6trlyWeEhPyiJEIKzKLxR8arKrdAH92172FxCoUX/f4F6oAQvu61
	 zUKL/zK4xW4dA==
Date: Fri, 20 Mar 2026 13:34:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: vfs continuous integration testing
Message-ID: <20260320-latent-klang-59c2fb00b3b5@brauner>
References: <20260317-gezeter-mehreinnahmen-60da36d16b83@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-gezeter-mehreinnahmen-60da36d16b83@brauner>

On Tue, Mar 17, 2026 at 02:40:17PM +0100, Christian Brauner wrote:
> Hi everyone,
> 
> I've set up automated CI testing for patches submitted to the VFS
> subsystem via linux-fsdevel. This is modeled after the
> kernel-patches/bpf CI infrastructure and runs vfs and filesystem
> relevant kernel selftests against every patch series submitted to the
> list.
> 
> So far I pulled Amir in. If you have interest in helping out here and
> maintaining and have a longer-term stake in vfs related work jump on
> board. I'm not a testing expert. My main demands were:
> 
> - No need for running yet another daemon just to sync stuff anywhere.
> 
> - No meaningful patchwork integration (no back-and-forth) other than
>   pulling series down from it. Ultimately I'd like this to be based
>   solely on lore and not on anything else.

The integration test-suite has now been switched to rely on mkosi for
building images and running virtual machines.

mkosi builds images for:

* Fedora
* Debian

and builds the kernel + modules. The image comes with 4 partitions to be
used for testing. Right now we run:

* Fedora
  - VFS selftests
  - xfs fstests
  - overlayfs fstests over xfs

* Debian
  - VFS selftests
  - xfs fstests
  - overlayfs fstests over xfs

Further extensions welcome.

The description is in:

https://github.com/linux-fsdevel/vfs-test
