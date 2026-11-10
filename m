Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319961;
	b=h3Pfr5+FHkr/APDZlFqFUlKSVVGekLqxYljeFS+w2wpBRhd0VPP4zGr0cyADz/T33Vwb
	 gA2KjE8tg5K0cP3Y79snXEsxh4nEVsmASe1BwhM+BQfhUZwdz+n5YwF0iSv64wQArstTn
	 rkp/2BkpbTwU33cLE7GCVXDkeRQMSnUzXSCu6+Hcq27qT6JuKm580kjP4QjNturP97/fi
	 L4hC1KI7bvox7L9w5QudjzmCwHDaFGrapN4RKXk02YumJ40bGmJv/OIVgv+Xdcf0ebjn9
	 b2r+YS4Nyk+9T47+WUhl3YGX2oVrqDa0GlGZCiJYrTrSiLssh05jtU3vAsMde/J3hZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319961;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6VgY6UdWu9zLmnF3aLHQsmOuzao3PITWEgw/5e5KuwU=;
	b=DJIb1TY4IGqkSSB2Q1S+UjwycKCAyBZoVlUG40wuv7+WaIIKm342qPSFv56WueZdvBe9
	 QWeFeq4EyPkZ+PyD5XHOSJIwrVyR+gPTLVwA2LelgsgUA2aVtxBAopCuyKL2TM66zJobe
	 UVBoxS0aICRusJt54vOQAAdJIq1fqg1sWtpb6f6IcU2vKWKBR81KtMeVzBZpUuHMPuYAG
	 Cnz2MWEobZHz7lNJ6QyUjvQ/9uQNh9w1WkQj/GgFCq/WNHNzr6k4OvGQvJCd7Utml22Qi
	 fn0Dk/eu8cysHbnW7Vr2+PB6RAjoeArrAlDh5tOmFMEHRWDcOLQtvG0z9UFji79hTtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qm0sZ2Fq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47C606A31C;
	Tue, 10 Nov 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qm0sZ2Fq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CB61F008A1;
	Tue, 10 Nov 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319960;
	bh=6VgY6UdWu9zLmnF3aLHQsmOuzao3PITWEgw/5e5KuwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qm0sZ2Fq4qPY1DKIKav6pqo7ACprob1rUv8p319SW6KFEx+TBxE4TRzcyKCZevuDw
	 0cS3uXOaW2KCkoqT8UtoX0z0uLH+IlOzbaDYK1NJ2eUKWPbwmLU9//qxzJMoLkU6cJ
	 z+KJzWh7p3OU9AP5hvCXIM/QjG9Y3VXFoWkP5jvm1xaEGEiE2FDCVIKdchuCWU6LB5
	 A+OF2in0nAygQ2p7Rnv2xCqKveTl1hrNC5jmHhshuWoo7YxUYQdDBoW+TUzrER2nUx
	 S+UYgfQUl1O5/x03wPgGptiG2nqhteMr27xLsPeRmuMu0yZxubY3OoAAJWJlzyUjXT
	 ogs7KmUEotdnQ==
Date: Tue, 10 Nov 2026 15:12:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: =?utf-8?B?TcOpdmVu?= Car <meven29@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, =?utf-8?B?TcOpdmVu?= Car <meven@kde.org>
Subject: Re: [RFC PATCH v2 1/3] fs: add filename_utimensat()
Message-ID: <20261110-ohrfeigen-broschen-quartal-28599cd8e172@brauner>
References: <20261104110604.126717-1-meven29@gmail.com>
 <20261104110604.126717-2-meven29@gmail.com>
 <35n54rrx6qq67j4fpxlvh67hal7zhmke2g5zcuhs5sbvxy22ez@nnnt4r4xng4r>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <35n54rrx6qq67j4fpxlvh67hal7zhmke2g5zcuhs5sbvxy22ez@nnnt4r4xng4r>

On Mon, Nov 09, 2026 at 12:05:18PM +0100, Jan Kara wrote:
> On Wed 04-11-26 12:06:02, Méven Car wrote:
> > From: Méven Car <meven@kde.org>
> > 
> > Copy utilities that preserve timestamps, like cp -p or a file manager,
> > set the times of every copy after its last write. To do that through
> > io_uring, the request needs the utimensat() lookup on a name that was
> > imported at submission time.
> > 
> > io_uring takes the path of a request when it is submitted and looks it
> > up later, from a worker thread. The path ops it already has call the
> > filename_*() helpers of fs/namei.c with a struct filename. utimensat(2)
> > had no such helper: do_utimes_path() took the user pointer and imported
> > the name itself.
> > 
> > Split the lookup and the vfs_utimes() call out of do_utimes_path() into
> > filename_utimensat(), declared in fs/internal.h next to the other
> > filename_*() helpers. do_utimes_path() now only imports the name.
> > 
> > Signed-off-by: Méven Car <meven@kde.org>
> 
> Looks ok. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Seems fine.
