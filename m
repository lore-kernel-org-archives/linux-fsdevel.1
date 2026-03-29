Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735552E0413
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774822443; cv=none; b=oiWC1MnKeR5Xq9TLG4enAmbgmRKhTQujtvny+5ZOw0yDSSXHREb+tMBhHYaS4aXPTHmllb76AcQjjx3vzVE5qxNCb+9OFrOJIsVq4iBXRZIgMSfFKFzBdMghpfGe7Xr15W58cRb/U/HLsoallk0YtTFDNkIhRM9C3LThQAd3W5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774822443; c=relaxed/simple;
	bh=TdpnfLy5b//2ELrgcuJUou+riI+rr/0AWRXbXsa49nY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=l0O0TwnsKk7pOXW4z7q1EvewDBucqBNi08LemHHOkWk0PtS/05p7nPAvxInzAUVlLhN9n6BxCCCNuqfLT04JEXDxC+wvi2Ne0BbrNemGgv0SbMH9ShtvIUUoeOdj3yy8HX43utqh+k08mpC03bK9BrP+G1GAY+jUjPxxDwg6wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=S1Jlfpj0; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="S1Jlfpj0"
X-KPN-MessageId: 92b940fd-2bbc-11f1-afda-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 92b940fd-2bbc-11f1-afda-005056994fde;
	Mon, 30 Mar 2026 00:13:54 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 92b8ac97-2bbc-11f1-80ed-00505699693e;
	Mon, 30 Mar 2026 00:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=VCb9BpWkOWb6vMOQalT/4lJ+M67YZI+aS+bRmI4TRow=;
	b=S1Jlfpj08zUAry+ne2T4brbbIzZzpyD006lGrdfpkfMJ8oBxpbeWBzjL/LjSdF/X3Gzf0fyxTB7me
	 Bn1lx2x0B2ZcdzcRCoi14xC4ecBYvI+QNsmr1deOXp8QvvUTL1T2QPc55jho46sxf75S/kxJgTcCMA
	 MP+cnpXhDlI5O+4l8Ku1XpvzKct1O6Bm8xx830QTR9w5gA/zFNZ/0nszARE0KBOq4CT0ZF0CyC7rEt
	 2BxoFojo/QeaqgoKC5yFa1MDqHw8ij9jmLnde1WkZbR1QZjSgfgaoreU6hxNKpWuNCkcSzcd0Veo5J
	 uBoCncRhqpcb5pni6dJxV4TzFN1xlVw==
X-KPN-MID: 33|MTrnjn7jl7Xjh3kaq4VJph8bnQq5zSRajPXtqgh5GkFWpI60c+fJOltSQSNkteJ
 DFJx9SRaipyMfU89idgsNdA==
X-CMASSUN: 33|PR+T1ezEb5NFaEXq0aeyK4TQPq3g4Zt/GGQVwvNyxkMJZkjZNVuUzxIrTIofRbD
 838FNdQvRWwQejSOzpCj5wQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 92afe6b4-2bbc-11f1-b8d7-005056995d6c;
	Mon, 30 Mar 2026 00:13:54 +0200 (CEST)
Date: Mon, 30 Mar 2026 00:13:53 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <637584867.403417.1774822434001@kpc.webmail.kpnmail.nl>
In-Reply-To: <2026-03-27-finicky-copper-turkey-process-LwZ9E1@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-2-jkoolstra@xs4all.nl>
 <2026-03-27-finicky-copper-turkey-process-LwZ9E1@cyphar.com>
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to
 openat2(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 27-03-2026 07:26 CET schreef Aleksa Sarai <cyphar@cyphar.com>:
> 
>  
> On 2026-03-26, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > To get an operable version of an O_PATH file descriptor, it is possible
> > to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> > currently require going through open("/proc/<pid>/fd/<nr>"), which
> > depends on a functioning procfs.
> > 
> > This patch adds the OPENAT2_EMPTY_PATH flag to openat2(2). If passed,
> > LOOKUP_EMPTY is set at path resolve time.
> > 
> > Note: This implies that you cannot rely anymore on disabling procfs from
> > being mounted (e.g. inside a container without procfs mounted and with
> > CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
> > read-write.
> 
> Actually, this flag doesn't need to be openat2(2) only -- all existing
> kernels will reject a pathname of "" with ENOENT. This means that
> O_EMPTYPATH being set acting as a no-op is fine for older kernels (no
> program will get an unexpected result from O_EMPTYPATH).
> 
> In my view, adding it to openat(2) is preferable because it means that
> systemd et al. can use it (they currently block openat2(2) with
> seccomp). This is what I did in the original openat2(2) patchset[1].

I changed this in response to feedback from Christian [1]. He did mention
that if someone really wants to add it to openat(), we should wait for their
reasons :)

But if systemd could use it, I think it is worth considering. I am not sure
why Christian was against it in the first place. Maybe to save flag space for
things that really really need to be also in openat().

[1]: https://lore.kernel.org/linux-fsdevel/20260224-karotten-wegnimmt-79410ef99aeb@brauner/.

Thanks,
Jori.
