Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958100;
	b=bRMFJ+EmF812229fREYmHcsC4YRiiPjFHKv4YlXgN5BrmFBDvAcTZIM8auKaFqkJMW15
	 qRomMgf07DHHwKZ22ZCJ1EvSjPgQw1V5Lk3Be0ac4G/2SL/pi4IFiuR6e85p3/TFvXnAn
	 TKmtuNxEjv99eMccexU7GMwRCb2wCFsquStpi56TIyR1u9ZuJVjcpl6KUEw68b4bsUCxR
	 95UuhiEctYIlN/MTkdAgXJC2HfbX+i4AJ+xIKXsdsgIXysC+eT7pVJqlEt1xlm69DOx/Z
	 XsI58xu0T8v2tF4QXkkyIiNeMo53WnIwTp07yW7q+rg1Uk7TkOEwf2fo0+KI735l8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958100;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0k01b4KCr3lBAz1oyTFGUv03HdoUUub6gz8vJbutKbk=;
	b=JOSyYN9+hbywfHzM0L/AZUy5heCCAp7cZb62EfUhC+H4FY62b5jGUm6huYLs2USx9uaA
	 w+bfORB7a9gLhTY7fuSazXxsqaAGM0rex9U0irKHVmWbdeyS3Xl+GkoDNHnGQYcMlb+Fk
	 VQ/9tedlO8OKbWSdAAABz3/uu0VGpeKaECRmZKOohxM9x6XrcnO8fitUYCFVKsmwQGuBI
	 wCJzZxkcpF1z/ddsRks6zMcGe4vt3+/N4QBg6ojZOXenqVJYTJidEZelsukoPYbC8g93r
	 SkvlN3Clthvajjm80OOxCw8sELMKFFnMPG2cfUg0q6lokQy668g8pzfqBwSmuR+KAFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2yf8Rkn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB1606D60F;
	Fri,  6 Nov 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2yf8Rkn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0131F0089F;
	Fri,  6 Nov 2026 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958099;
	bh=0k01b4KCr3lBAz1oyTFGUv03HdoUUub6gz8vJbutKbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2yf8RknN4uPgj+PX79Jpz9h3D1OqVf8HcADbLfPRViiniX0KIi7frupdk7Lja1JX
	 4JxpwmhSgY/+6JhA+A6MvaCSpm9VEZqwUnhrz0zvgiSH5KYSKqfZx5KM31RN3gBMRF
	 6WCoFJhj1k0lSPXkaIZOfIu9MZ/MElX2kEH8HKuli5ALp2LCEKgxd+WXIUo2n+Oygj
	 8GeclouIHQdyY18JvUerscP6abtLq9usvwiz98d+cDj3sQrXgFBcVesTq0Ur6P5sU7
	 +c8ACGSUP3Lt4kxXKDe/XODxJlyVWyR+C7OO4JXEICU7SZfMKM+6BRqN5XFIVEkKMb
	 oDtQfvT4LJhkA==
Date: Fri, 6 Nov 2026 10:41:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] file: Avoid acquire on shared fd table lookups
Message-ID: <20261106-ohrwurm-gedenken-feigheit-c9e9dcd3c0ed@brauner>
References: <20261104092750.2998440-1-bobby.prani@gmail.com>
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
In-Reply-To: <20261104092750.2998440-1-bobby.prani@gmail.com>

On Wed, Nov 04, 2026 at 01:27:49AM -0800, Pranith Kumar wrote:
> __fget_light() reads files->count to choose whether it can borrow an
> fd without taking a file reference. The current acquire load applies
> to both branches. Only the single-owner branch uses the count load
> to order its subsequent fd table lookup against a concurrent
> close_fd() and put_files_struct(). The shared-table branch obtains a
> file reference under RCU instead.
> 
> Read the count without an acquire and use
> smp_acquire__after_ctrl_dep() on the single-owner branch. The branch
> provides the control dependency, and the barrier preserves acquire
> ordering before the borrowed fd is read. This removes an acquire
> barrier from each shared-table fdget() lookup on arm64.
> 
> With two threads sharing an fd table and each performing 10,000 pipe
> write/read pairs on separate arm64 cores, performance improves 1.75%.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  fs/file.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 4cd40dfa6129..20ab46434abe 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1337,10 +1337,12 @@ static inline struct fd __fget_light(unsigned int fd, fmode_t mask)
>  	 * entry combined with the new refcount - otherwise we could
>  	 * return a file that is concurrently being freed.
>  	 *
> -	 * atomic_read_acquire() pairs with atomic_dec_and_test() in
> -	 * put_files_struct().
> +	 * The acquire on the single-owner path pairs with
> +	 * atomic_dec_and_test() in put_files_struct(). The shared-table
> +	 * path obtains its own file reference under RCU.
>  	 */

This needs a litmus test, a TLA+ model, and detailed performance numbers
with reproducer for both the shared case and the non-shared case.
