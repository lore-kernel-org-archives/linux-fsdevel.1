Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9873B0AC7;
	Thu, 10 Sep 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071991; cv=none; b=EKeiGqc1L7Ns3kEyAEBbFtTZ3P3GsacmNqXUYyUvx2d6mn2VU7Rxgf+sH+TgpAsP8P/uwOHudaADJ43HAAEegr13GfJXJ0I8C207KAWdmycP1uUxRf1FWd/9kOuWuwktY6J2uPFDyJmAyiA0E6ZsqKfrRtyBGaC1g0QcKAMjJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071991; c=relaxed/simple;
	bh=7koiVX/lCaxcGb0MkS76Fxd7ELAOTzsK6AQ3YEBq6Iw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQRhEY0n1lZFPunY9S9v/35JayrT03DFD1W/lGzeBIciKk8IJFV8WptOsP3o6I2FNzTLwclkwdJJXanbl5O3x5YZlqmYnJpKc4CyTrlNXR2azNOjdKkYQq5NSOOdbNw0I0ZNtT0JKRTCjhYXHn4Vn6B/SdjoF4sbpHES4exlybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyzzpFcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyzzpFcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB561F000FF;
	Thu, 10 Sep 2026 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789071983;
	bh=7JYzx+I4R+iQOFjAX/HqL1NA0EJaM43MXTTBGSVtubI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyzzpFcFQSteZyeqxeS/CdS1niqa/6nmcVEh5kaqNYhF8jBsZQ9KsQUipWwNBcqay
	 EL67nJbYskOXHmmx/N3U2boCLT7hF8HsfB/WjpCxJKOjf5oSfCC7ThjPNyaHXVDl5X
	 fVHWC4UpMZcIgz3WtzHPkuSemMZEsku/hAfd/kw/k3CZQN1pe3aF73lgc4Z88ToZQy
	 yO1dzVWbh135pXbpPQaji99z097JoUlDYqOmW+RZJJ9Ljnoar5xyWyxfur/WaFUsu1
	 heYeb6ZtJfwF2iM+vh6F+mnTq2qKgt8EUD9IoWGAlUlsDK+0S/rrKQpBAdnf5eiFJD
	 ZY4AqyWmPoU1w==
Message-ID: <10a6491d3de9cd67dbeccda8bee4ae7c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <christian@brauner.io>, Tejun Heo <tj@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernfs: don't hold kernfs_rwsem across dir_emit()
Date: Thu, 10 Sep 2026 10:24:18 -1000
In-Reply-To: <20260910003650.1680854-3-shakeel.butt@linux.dev>
References: <20260910003650.1680854-1-shakeel.butt@linux.dev>
 <20260910003650.1680854-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Shakeel.

On Wed, Sep 09, 2026 at 05:36:49PM -0700, Shakeel Butt wrote:
> under the lock and emit the copy, and pass it to the resume so that a
> resume within one call keys on (hash, ns_id, name) and not on the hash
> alone.

Please split this into a preparation patch for full-key resumption,
including the name copy, and a separate patch dropping kernfs_rwsem around
dir_emit(). Keep the existing locking in the preparation patch.

> +	pos = kernfs_dir_pos(ns, parent, hash, pos, name, &resumed);

The fast path in kernfs_dir_pos() still accepts the pinned node based on
active state, parent and hash alone. Please compare the saved name too
before setting resumed.

For example, akl, ala and baa have the same kernfs hash. If readdir emits
akl and it is renamed to baa while unlocked, the fast path accepts the
renamed node and rb_next() skips the unchanged ala. Falling back to the
saved key would preserve ala.

Thanks.

-- 
tejun
