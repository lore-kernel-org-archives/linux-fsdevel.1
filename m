Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793593875;
	b=PedBeR30rD9bPGcWt+SttQ/mOfS3cPRVRRnfgRiUlFCZaGnM23RpfNaDJh9U6zP6I2sE
	 XdftvZwxOiFQ66QrkNVrt3RdnjKLFHGAW2zIqNHgHOKvxEgWdCU0n6Zipb/WUfmZeJV8v
	 NImxYZyZZP4seWIPg3SXZU/E+9jAnbcXxnoAGYREswQlR9gLbLZjSWZUSCufGAztOeI5B
	 bwaFB6hIkHR9VFUXzciop2XBejPxp9kX2O3bBsY2oWJJT3Uy7xqCYOaVhidQOJEYMiHpd
	 ZD4+3oLWyJw4nqtqURrosJsdkqhp8vRoR9bOoRB1GhL5OXpYwL7LNkXypvV7m/4W2NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793593875;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=V3m2ZNXA+cWC29f7mK6AOHGojqkL4QaL7wZFtjfryik=;
	b=XYyGHDagzC1Ie4gYiwRyr/GzZNoszINbvwPTzV+gZvfQ7oAf0kMniDSCoV6dvUj5xkKq
	 d3ol7qew2Zkjebx6YPvPzHIfb+mVz/vV3jF8jh2J1TNoX3HR6OULujbAcxqRxPKB9v1pT
	 Z784aczK4AhS3kug/v2eI3xHLTZSBhKX5di1cD+8sCQtcM3riwIjckFckVT+3gUH0Nv/0
	 CMhTS1CVp2ItUyAOyw5VSHAM/Y4ISJX8NC7DqFSBNcU4TtnwZg0y+Ty3lz2bwTW4QXG78
	 a0Ch1zDXyNCi/4idARpjRnTKRKf+tkYelk2dx9W04eKSwn0+iz+z/0n8Y5lxu+212gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wH8rwnFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AA606A326;
	Mon,  2 Nov 2026 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wH8rwnFL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DE71F000C1;
	Mon,  2 Nov 2026 04:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793593874;
	bh=V3m2ZNXA+cWC29f7mK6AOHGojqkL4QaL7wZFtjfryik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=wH8rwnFL550O3cYb360HQ+mDxf/UbGTeI1i5ixR7DkekLgY4sBaphFzk93BlNFcEp
	 WaGsinhxDOkFzK4NcKkDqcM8AkT4Tr87GxuU4ZmlQ64c5bvOJ06dzswmMnckQjoex0
	 sDvWAQ5Qrl8cGA+onlFrEmZ8CXqmfA9k0l8bJoVg=
Date: Sun, 1 Nov 2026 20:31:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/proc: proc-empty-vm: wait for child's SIGSEGV
 instead of sleep(1)
Message-Id: <20261101203113.74d0204f6d57deb81cdd0dc5@linux-foundation.org>
In-Reply-To: <20261023183434.9109-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20261023183434.9109-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 19:34:33 +0100 Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com> wrote:

> The test had a TODO asking for a reliable way to know when the child's
> munmap() has finished, and used sleep(1) in the meantime.
> 
> Unmapping the whole address space leaves the child with no code to run,
> so it segfaults. Since it is traced, the SIGSEGV stop is reported to
> the parent through waitpid(), which is exactly the signal the TODO
> wanted. Wait for it there and drop the sleep and the TODO.
> 
> The stop is now consumed up front, so SIGKILL the child before the
> final reap.

Thanks, checks out.

My review toy claims

: Separately, tools/testing/selftests/ptrace/vmaccess.c has similar
: sleep-based synchronization. A delayed child can make its attach test
: fail spuriously, or let its vmaccess test run before the intended
: blocked-exec state. That deserves a separate fix.
