Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6838B12B;
	Fri, 24 Apr 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027829; cv=none; b=QQiuPLqMyPtHlM2fC4CIP0H/w2qw55B2/xh1oKSanvqtgUkbu1BYgoEjeXsrbAGi1RsOldJzVOkn3WFHcr8N0+Xi4NkwsOyPLijxkwyukQZbc0txLO15PiEhgQDzTtwevZxzrNgCPlVzXBDfp3qaYyPebw5fC8q0Cbmkv9ikdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027829; c=relaxed/simple;
	bh=TDU0AlDqujHmavTcIh75lBnIX6mV/USXrPETPBmh7BI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aTX78hIUFpAicMj1ZPODgbahyfk8r16gqm0guiMe7ShTD/rmkVVWgyTvhfYdS+TEXoRKMf3WP5pZb9Ukc5NcUIhiDokyH94MkwT3oS25rCimlzBxzEL/FXpf9lhD7YSSaPmfNuSP/MiQDtgSB8OKItZSZfbXEYSzjM2N7WOjgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x4+HNoNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x4+HNoNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F68C2BCB4;
	Fri, 24 Apr 2026 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777027828;
	bh=TDU0AlDqujHmavTcIh75lBnIX6mV/USXrPETPBmh7BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x4+HNoNXHXxFDOIvn33wAoBwtd53Krh+L7xximTARfzKR0D95RL7q75OSoDOLDZpc
	 GkQlEpSvkoOsseB8Vu4PV6gbHuQNNn/KVcvp/Ah9x4ldLZ3X170wlGpEa9RTiDU8an
	 DvMO3CLGIbfLCu51+dIFcaAPIaXo+Nd5q5oufHoI=
Date: Fri, 24 Apr 2026 03:50:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "John Stultz" <johnstul@us.ibm.com>, "Yao Zi" <me@ziyao.cc>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Alexey
 Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: fix comm_write return value when truncated or
 error
Message-Id: <20260424035028.a811dd6bc8248b640a9fd7c2@linux-foundation.org>
In-Reply-To: <20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc>
References: <20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 04:06:21 +0800 "Shengzhuo Wei" <me@cherr.cc> wrote:

> When count exceeds TASK_COMM_LEN-1, comm_write() copies at most
> TASK_COMM_LEN-1 bytes but returns the original count. This violates
> write(2) semantics, which require returning the number of bytes
> actually written.
> 
> The count parameter is size_t and should not be repurposed to carry a
> negative error code on the same_thread_group() failure path.
> 
> Introduce a local len for the truncated length and a separate ssize_t
> ret for the return value.

Looks right to me.

> Fixes: 4614a696bd1c ("procfs: allow threads to rename siblings via /proc/pid/tasks/tid/comm")

December 2009.

Hopefully no userspace is depending on the broken return value of a
write to /proc/pid/comm.

Arguably we should leave the code as-is and add an apologetic comment
explaining the situation.

