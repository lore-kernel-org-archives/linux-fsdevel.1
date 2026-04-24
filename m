Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D23D3D04;
	Fri, 24 Apr 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037732; cv=none; b=XhpevDIGVCgDV0wytRTUABCUhlS5a4y0IJuZ8ajGUT8iUy6vHaKJ+4YRjGHQ3+Cf29kgkx0qGZ3yNssy9knZMFL7HXOFzSUyyLN67//Fptj7uCi70isipgrZkpcGyW/byhLisbccnqrXwyqAZ+gMNzSSv1Ebja3HT5gE/5ehD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037732; c=relaxed/simple;
	bh=H6sObuc8FxlRFqTOhDxEaZs0dJ92BAEP0F9ccpRvprI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p59WGwvQt4OD9jMcy4eMbZiitVWKEi7vMR6gFFyRLIAUB3FXBjoo/NvT7QP5pUcc8zrf9uTnxMBs8GIKhXT3ieaZhe/ICcTu55GKCUDep4+XfZzPp/71+6gWl71uek8tKUBa9N4blxhMXACzLdqU8jJvpC4EJDF2l18I/Aumeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sln3Pkmv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sln3Pkmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05694C2BCB2;
	Fri, 24 Apr 2026 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777037732;
	bh=H6sObuc8FxlRFqTOhDxEaZs0dJ92BAEP0F9ccpRvprI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sln3PkmvyTZ5SOEYxrpV8ThqFzY2JbyL1G/on6R2lUmdrkJQoTo7FJc9EITQOUa+U
	 U+qJXmh+ac8KW5pGC/EuXxkDEXh2GxehatRjy0V+AXtqVfa0H/bffWLUkGrq5sArJH
	 LdFyf709VMrA5rz9x0WoDXhcKaCSXeTqKOPyn3QQ=
Date: Fri, 24 Apr 2026 06:35:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "John Stultz" <johnstul@us.ibm.com>, "Yao Zi" <me@ziyao.cc>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, John
 Stultz <jstultz@google.com>
Subject: Re: [PATCH] proc: fix comm_write return value when truncated or
 error
Message-Id: <20260424063531.d1508a3c79c4b7808ed04420@linux-foundation.org>
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

AI review asks a good question:
	https://sashiko.dev/#/patchset/20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc
