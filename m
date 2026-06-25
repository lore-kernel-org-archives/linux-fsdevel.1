Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF22641CA;
	Thu, 25 Jun 2026 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378369; cv=none; b=CvXDb7INslR0nlhSiToSka2sWCP7M5sS5MpQB9rVgmYUCMQlIEoV6Sr8Mdlf42L++L99Lbc72vHC1cLdoEPALNH6NHlrg6IKS3NHGHdOkEsGGY+ze/otuLn0jidRBoKDO74+tFpy6ZMinT9+zXGKds/XTqAYg3DaY5Y5CQY+0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378369; c=relaxed/simple;
	bh=xEc7PwB0aZFN6kLw3o0sxDzg+juoNMlh4TG7p/UsZOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vGQO9nunG/48/kc4NnPvIzLOvbrDLQsF31QcgkrP9WsxA3/vMsKVQdbGIfr89aB5ZrmPFvNBKfOqbuto7QGhd5fxnW2pOwAG3Ou9NXYesvgsTw/6QlWRD3kaBWMl2aXDY1uKBlMCBCY2Saubb+/xKI5vBbxlzPD3w2OkiVTQCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGUZR+Pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGUZR+Pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7C1F000E9;
	Thu, 25 Jun 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782378367;
	bh=uWgZuaM7iYZt7359X1HxJyqC3nPtLZFOpucffsH2wXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gGUZR+Pmd8hdHISAqIzcRl3hmfPpYxddIlJxAJNelBq2PMgqY2bGB1gn/o1J8/fqV
	 59NTkSRahwRttvehSso/thYLDcRNzZ0lxVwSPidD/wrLyKMO3AoCHasO2KdSotcBeg
	 jmABSXee0C9aVIauoK4MnrnMKMz9PIuUq6JCszf7kJ0/Bc139fnYjtJEPpaogDQ9xP
	 akH1+4QL/VtY6QzrvheG2MDeI9AQogxcjv3pfxXgqfgywzhcCwqduFFXx+s4SuRwMZ
	 eoFP3Q4bTx8lYp46TKZj1t/9c/LrMpAj71JxXAMsCFoE2Nn2HAo2sf3H8YUwGIRbIw
	 /MUqeEuknHjeg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,
  linux-fsdevel@vger.kernel.org,  pasha.tatashin@soleen.com,
  linux-kernel@vger.kernel.org,  rppt@kernel.org,  pratyush@kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
In-Reply-To: <20260625054946.73445-2-duanchenghao@kylinos.cn> (Chenghao Duan's
	message of "Thu, 25 Jun 2026 13:49:45 +0800")
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
	<20260625054946.73445-2-duanchenghao@kylinos.cn>
Date: Thu, 25 Jun 2026 11:06:04 +0200
Message-ID: <2vxzfr2bkn0j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 25 2026, Chenghao Duan wrote:

> This patch adds support for preserving eventfd file descriptors across
> kexec live updates using the Live Update Orchestrator (LUO) framework.
> Userspace applications using eventfd for event notification can now
> maintain their state across kernel updates.
>
> Preserved State:
> The following properties of the eventfd are preserved across kexec:
> - Counter Value: The current 64-bit counter value, including any pending
>   events that have been signaled but not yet consumed by readers.
> - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NONBLOCK)
>   are preserved.
>
> Non-Preserved State:
> - File Descriptor Number: The eventfd will be assigned a new fd number
>   in the target process after restore.
> - Wait Queue State: Any processes blocked on read() operations will be
>   woken up and need to re-establish their blocking state.
> - All other internal state is reset to default.
>
> Changes:
> - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd state
>   (count and flags), and eventfd_create() helper function.
> - fs/eventfd_luo.c: New file implementing LUO file operations:
>   preserve, freeze, unpreserve, retrieve, and finish callbacks.
> - include/linux/eventfd.h: Export new functions.
> - include/linux/kho/abi/eventfd.h: Define the ABI contract with
>   eventfd_luo_ser structure for serialization.

Why do you need to preserve this? Why don't you create a fresh one after
kexec? You just preserve the counter, which looks pretty much useless.
You can just as well open a new eventfd after kexec and set the counter
value if you care about it.

[...]

-- 
Regards,
Pratyush Yadav
