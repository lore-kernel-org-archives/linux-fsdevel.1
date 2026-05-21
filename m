Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AA231832;
	Thu, 21 May 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324566; cv=none; b=YKyNa2qCDqYqjWAsXam/D3Mh4FZlY3F6QLpIobzmhLxDffpgOWNoXwuHn3F39BDafQj46OnCMFXVMTe/jxMmrtKVMVueEwAIkTArAB9gM0otZl0HCUJevlfttl/jS930wj/tFT30qklt26KyqqA0ZaYSOhL6x0vYp3iwO+UqOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324566; c=relaxed/simple;
	bh=Yjv+o2dLnx+bQffr0Dm08/pe1YoI6KvXkq4LH35rHQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwWmZWFl3fC4f+bj0tHOZXHXHg8XjSMvj/dKDo3+VVSgh1gdo85E1LR5GtbNDc4QeUydxJJK7Rt/62k9By3dog4GaW/byW0ftd2CBEHPEBHEeEsknBp4pNopujeNmU6TgVf03fVVq20zAh9CALSPP5tkkgB0aF7SvpO6GYXhBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJNU28/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJNU28/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279631F000E9;
	Thu, 21 May 2026 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324565;
	bh=KKo1aP0/SKSLwZJzYxUUuw1WaMCrB0NW5OiyxLWZ3zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJNU28/gJtiaRbltyxshjoVgo0C4aGpGSML4BCYjRSvwHeu2htfow7DljhONdgvsL
	 ebXc9MJk6xUunU9zYuY6oXatyHTVKc0guNAI+pWh24bj6n6Z3SiRIsjGk7HUlbhZva
	 e43RGZpcH3cSHlQPYNJyF24pw5Y38SgPhsOyiJYAzOzWkTjzRuVUN70rdLhU9zxlHk
	 sfOGrdLA8ii6jlNcxuodnQbDuxty653WGIYVTGbU4nNbcBvCllHqberOWv/ejV7SfN
	 lodFJ9jeT9bkOfefvzHOziT/ez863XRAqk6Z7bZkeuWmPSNfX7J9y09XeGyfiKzZIL
	 xj6EZAbI6PwXA==
From: SeongJae Park <sj@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] init: do_mounts: use kmalloc() for allocations of temporary buffers
Date: Wed, 20 May 2026 17:49:21 -0700
Message-ID: <20260521004921.84647-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 11:16:51 +0300 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

> Several places in init/do_mounts.c allocate temporary buffers for
> filesystem names or options using __get_free_page() or alloc_page().
> 
> Usage of alloc_page() APIs is not required there and only creates
> unnecessary noise with castings or conversion from struct page to void *.
> 
> kmalloc() is a better API for these uses and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_page() and alloc_page() with kmalloc().

Makes sense.  I once wondered if kmalloc_objs() fits here, but kmalloc() also
looks good to me.

> 
> While on it, add a check for -ENOMEM condition in mount_root_generic().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
