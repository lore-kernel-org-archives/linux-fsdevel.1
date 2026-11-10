Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323525;
	b=miYs7FnTh+B3FqOLpEUPuQJ8EHiazBVCbg0kMdBILaH7WqJ8JCSMYi0HdAFfokw5ZIri
	 d+kT9BTI/Q0DZjPHaWI8Kaf3VEYuJa8d6g3dVbrdnq4cIcto6ZnYvm7iJ/KaBY8GSvOSD
	 F6BIhlqK1ICzGnmqlH8h48hH+AAB6vdxBb1Tc2WhlZ4RzJfNlwfyomFtkFbEB8Pf7zMHA
	 BtqQj58SJNEpklScWqWQ+woyBm8Ee//78X3A5BIDslUzhaSXL7bo+icUjnDLzqNdZqza5
	 NfC5DY8nmfhPdYKtSPSxQoquZmO1hDbNEpkcHRzGhGyN/Ma6GHInzoHNr38WX79+TBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323525;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BpOu03mqe8+569yMnc1nFjJQYuHWTZsW9Ql7tSErufw=;
	b=sjSAR+nDpjVCg/BKBhFGqnYL4PjJPxD8aI8UhF+HsoNV/aoMXg3tqeszeWrZggzjJpkK
	 0OMEJMDU3UvDl+Dy14ilGq+3dX5vQ++6aQLg3X8HouY8erzKUUfFUeZHeYs6GSrBuAdb9
	 l07qkjvjZshebBasIWMyN2iTTYryeTTn53GZZewXMQzgblZpT3FFXWAB9a9wakHpPsNsV
	 c9TWzHIKnLjgZb743I9oF03MrV9yuqzHov7vhFrTXJ+mXmNn9dg0M27s6+cLNjY1a2GPZ
	 5xGWNxmlGZzbMjwdM7LsK/ANZLMDRDamH22TmPMxyCd5d5E6K5STk3MHf6O1gxn3fAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbkcrahi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFB606A323;
	Tue, 10 Nov 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbkcrahi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1801F0089F;
	Tue, 10 Nov 2026 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323524;
	bh=BpOu03mqe8+569yMnc1nFjJQYuHWTZsW9Ql7tSErufw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zbkcrahik8+xSqRYTnEkm0yVJv/vFX8mkNhSvcPWBqwOomUnPFnkUindh22AZ8j49
	 8p1HIrSabX8EyDFryCW8/k/e04Vh4P9JMZKKzYiFGQZmNiPkIC9ASdk++bn5M8X1tx
	 js5tzmbaRXs7J9tFZNAgi4H+G5SLU8IJkpbOWbBGHy/ySpUdlUr4+xpgAFKCfZ5/vz
	 I9v2QOXQgcXRevgFmMwFZ9ahtg5/LGYGvQ6RQcJfwHWhbNhuGCy8uCSGIYvhhY+/zR
	 wDc9HR/Oza4R6tipqA4fePWYGWf+ALX0TMArDkrFWMi8DMPr+wG9vjmv3tC9vnB/e2
	 vuAmwwZ15e7Qg==
Date: Tue, 10 Nov 2026 16:12:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>
Subject: Re: [PATCH] fs/splice: clamp an over-reported write_iter result
Message-ID: <20261110-verfechten-gastarbeiter-wehten-bc206354fcb0@brauner>
References: <179328314072.648427.13388575162083843840@gmail.com>
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
In-Reply-To: <179328314072.648427.13388575162083843840@gmail.com>

On Thu, Oct 29, 2026 at 07:12:20AM -0700, Cheng Yongkang wrote:
> Commit a3de58b12ce0 ("netfs: Fix unbuffered write error handling")
> added the warning for this condition but only reports it.  Clamp the
> return value to the size of the iterator that was actually handed to
> ->write_iter(), so the pipe accounting stays consistent even when a
> producer violates the iterator contract.

The actual bug is probably that proc_sys_call_handler() returning
whatever length the bpf sysctl hook put into count. That's fixed by [1].

I'll probably take this on top.

[1]: https://lore.kernel.org/r/179328314073.648427.7892850166511253762@gmail.com
