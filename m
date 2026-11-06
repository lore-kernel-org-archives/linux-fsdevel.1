Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955049;
	b=mJE6hE646Ap3pBjqSFHk3HOttrsFopERwPr3APsgWCBtZJtSarN1NUsksaBuWRsFA+Ah
	 NWK/Zs6YKJds3qvsc/bjChscv0iojQ1ndEw2aBBV/aTJ3rt+W5GHIihjgj9WYY1TE4bGZ
	 PcJbVNelPjJsKXFs+L93ZdqRDN7aOLcDr0U00eN7rUfq4TFERsrV2OIw3gTEOs9X0V/FG
	 qW83y60VcgEmHrXc1qwwovZ3ZdjyoHtMpKqRAmB+KhIyUQKapWTK0I/t5+f5zLSzdRvip
	 TvUh61aBfC1FoZjOF7IG6OVkGVSXu5X2c93aMS+8216nRQjJPTJEhvokt5/neYF8eyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955049;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=02bTvKdX/nLQXHFQBIjVYXN/kxrugSr5DOL02V9CjOk=;
	b=B5EjEvjkIVD1FFb0UsbmfM3T0tjyugh+5l49NN+lXXSUcQgmPqBjaogEzw2PDtUqZ6uX
	 05n3EBrQiewLn2yk/NB6zrKNRha9WQw9Bcx0BlisJ5nrvId7wLDCnVrA5bHF+Sl4n1rIx
	 kRV+Wmh5KzsGRnRbhfGHExhQnN/xeWT0fsS5WBIfM+SD/0dMSzR/JK4d4AOYoE0cvKmY8
	 EGNlYAGRjEwkoyhzx6+2yeKE3cKa6mY01egkA5NVXceyvwEkCskaV8wS9p99bHlnGf8jI
	 1YeunayzmX5Oq9dEG1T1Ki7KWrIEaKs9sEtKw9Ld/fjZ4JPGOMhbBQQwpYSW5r+2C8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHTrEBdD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2BF606A32E;
	Fri,  6 Nov 2026 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHTrEBdD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05EF1F0089F;
	Fri,  6 Nov 2026 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955049;
	bh=02bTvKdX/nLQXHFQBIjVYXN/kxrugSr5DOL02V9CjOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PHTrEBdDBSiwKzS96GP4yyPbf54VPsZhbqgUKooUIbljVADoG67pbUzARy3kLUqfn
	 3sIZAg7KmzyWCHPA+ZdfHII8SIPAfdwqe4nc3g3VDWJq9ZmI15ZF3MDkQIZfRjNwsy
	 v7FF6UEpMj9UjlNL8x2U7uPmVYS41Qnowsqk27Sbg/99eaX7YxroTO9KnXlhl536B4
	 N5ec3hTgYO0RrMmJSC8aqug7YGJzjd2/NULM6TtRy2yW30Sp2JTe0j1vj0two5dH8S
	 YGHlW3ge4m3cRbn3GxdEvcRP6VgGPiaC40z3Pnhcv/f5fr0BRrKXoRdQR9ezvfBmuD
	 38wN3f+UpUJkA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Luo Qiu <luoqiu@kylinsec.com.cn>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <A977B5B944F3C7C3+20261027122647.1837472-1-luoqiu@kylinsec.com.cn>
References: <A977B5B944F3C7C3+20261027122647.1837472-1-luoqiu@kylinsec.com.cn>
Subject: Re: [PATCH] fs: fix typo in do_open() comment
Message-Id: <20261106-spinnen-infotag-rodung-330f26be4c2e@brauner>
Date: Fri, 06 Nov 2026 09:50:45 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 27 Oct 2026 20:26:47 +0800, Luo Qiu wrote:
> Fix "acess" -> "access"
> 
> Fixes: 161ce1e692d0 ("fs: avoid spurious dentry ref/unref cycle on open")

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] fs: fix typo in do_open() comment
      https://git.kernel.org/vfs/vfs/c/37ebe00ac282

