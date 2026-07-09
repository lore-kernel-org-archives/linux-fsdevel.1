Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE121638D;
	Thu,  9 Jul 2026 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589881; cv=none; b=nS6Wky1vTjD77COMJTgDUddCE8dri6/bEmQT/0MmqidJiKjxEHfSPyJ2T6pJg6EZii6LlhBiickrW5mCa1Q36Px+B2Q+HvJ2VEbw9mKnynaJss3SQUVuUUaKXCGi+ydmHf9thJ17ygvgoCe5UxSoXUg7I1fly5apyEJmkb87Lyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589881; c=relaxed/simple;
	bh=jRCInG3afP5itRbOxnB/Kw3VpkQae5qsb3RUTlTobJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0ECt+OQU5ext8mUzgWtESK/zVClquJafDKbdLZ1YB2jThXLkMhssYtjRJjJzwSGoGz8Q3H/uLvMIpm0COFEM6HuXEy3g43dGETFt0o5HdQ/8XiOKpvB3Dht/RDoPr+0WECqXOEubkWH8wYVH8MxR7/T75yye92O4bKLpi/uw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=etkGFSaA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="etkGFSaA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=J3go5mxmIJSmLAr8Enxl2wMPSVOmksps62bomS7mxCs=; b=etkGFSaAQHoEtL6sczR4Px5E3O
	ujXu/k86cFaIdF2z/xMor82em6zgXVjrnjs2pnCzKDk3b8LmhMHQE20FWWEl5ak0ik9XiJW8HkiKN
	52mEeY0GHG+FC9lm4p7OHmMcGG4DXSwbrTLmnzBiMC+9WSbJS/36wtOJjdAnBIE3AVhkUYtqUKGZ3
	C/2Ct3kbO5ISSbrkoCME4COfFS4cgqUD7dTSD+3cK2Hwzbd9cmjU4djsbvMjzxZUJ9vJIdWplRdFx
	3jC23Ij2UbAOV/O9fJlyE/ZzoZkAJIpXXZ0edfJRn4NWIVa/GVHioOgnrRoMUFbsGVlqhn5xfrtSq
	q7xK+JRg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whlCY-003cWq-2Q;
	Thu, 09 Jul 2026 09:37:51 +0000
Date: Thu, 9 Jul 2026 02:37:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, oleg@redhat.com, 
	axboe@kernel.dk, kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ak9re6AYFpQLz59L@gmail.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
X-Debian-User: leitao

On Sun, May 24, 2026 at 07:44:57AM -0700, Breno Leitao wrote:
> Throughput improves +6% to +28% and average write latency drops 5%
> to 22% across every configuration.

FWIW: Kernel Test Robot detected similar and slightly better numbers
with this patch, and reported 29.1% improvement on lmbench3

         %stddev     %change         %stddev
             \          |                \
     37316           +29.1%     48191 ±  2%  lmbench3.PIPE.bandwidth.MB/sec
      5690 ±  9%    +153.5%     14426 ± 18%  lmbench3.time.involuntary_context_switches

https://lore.kernel.org/all/202607091015.c3936260-lkp@intel.com/
