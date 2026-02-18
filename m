Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B025A321;
	Wed, 18 Feb 2026 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378539; cv=none; b=tTrCyUSYb15KJN/Nnv0PPM5uMQMy93hakEdIhrwAbHq0a8Ya+62l9shUo8ZQ2ITfUVhs7Vp0rYGO2GxSB6rlPpf/gruqDJLY5Mzv/gVqZQVSj8nGbGvWiFiQG8bwhlM62N2oNke2y93q2vfRYzil6g/cxxkJQtZmIyxCoewFkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378539; c=relaxed/simple;
	bh=q1L0/IcW/OqIdvAPKJk0wwAMUGfVTbkxDxV57xYqv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXMtakOzN2cy/6RFX//KoZL59LIQmmcCJTU457ka760DGa/GDSsBrBCqVoHayX4c9JslQCvrNwEASv3FrutK7hJfv+/YkOlL6tUghPRq552N57WgSXBae8kHsSUxtt9JmIgxIJ7Ppzih49yomtY60dK15RX3fGLd1g/X7Udvt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAt+dd/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAt+dd/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06060C4CEF7;
	Wed, 18 Feb 2026 01:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378539;
	bh=q1L0/IcW/OqIdvAPKJk0wwAMUGfVTbkxDxV57xYqv9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAt+dd/oz3/Tj7Y2cSPqS/MJlCa2TQuRIs6BAk3CFnFsXe0CZiuHxVRb6dIqpXiGJ
	 7MbNtkmjyTfX4zfLEGHqj21s21602gQUutexWCQCjsGT7a6vzepIf4UaeqNgS/0FJQ
	 64rBCw9C5fGgAWgz4Dy1rY0UfhnEvwYMHjzqs9nPWPOZSVIgGU70bZVv6JIZI0/dPL
	 IEip8xxTL0kkOsjWyQFX3AoXiNLh+E8ZRQrWPvkFjP75g6wsgz8B+F/eeYf68UActj
	 gu6vByz8VVRGNlTuKtgRAxRuW3H0GWa4Te8v4BRZKEBKdEJ9a4BUbf7GE/GsVHj19F
	 s4D+43cAnpfkQ==
Date: Tue, 17 Feb 2026 17:34:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v2] fs/file: optimize close_range() complexity from O(N)
 to O(Sparse)
Message-ID: <20260218013451.GA3161@sol>
References: <20260122171408.GF3183987@ZenIV>
 <20260123081221.659125-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123081221.659125-1-realwujing@gmail.com>

On Fri, Jan 23, 2026 at 03:12:21AM -0500, Qiliang Yuan wrote:
> In close_range(), the kernel traditionally performs a linear scan over the
> [fd, max_fd] range, resulting in O(N) complexity where N is the range size.
> For processes with sparse FD tables, this is inefficient as it checks many
> unallocated slots.
> 
> This patch optimizes __range_close() by using find_next_bit() on the
> open_fds bitmap to skip holes. This shifts the algorithmic complexity from
> O(Range Size) to O(Active FDs), providing a significant performance boost
> for large-range close operations on sparse file descriptor tables.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
> v2:
>   - Recalculate fdt after re-acquiring file_lock to avoid UAF if the
>     table is expanded/reallocated during filp_close() or cond_resched().
> v1:
>   - Initial optimization using find_next_bit() on open_fds bitmap to
>     skip holes, improving complexity to O(Active FDs).
> 
>  fs/file.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Well, the time complexity is still linear.  Just the constant factor is
better now because now it skips 64 fds at a time rather than 1.
Probably still worth it, but the claim that the time complexity is now
"O(Active FDs)" is false.

- Eric
