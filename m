Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819419;
	b=VFwo9NKxONQzDyzw90/PO6M73yDnARc5Vd2hjGWMEt/WHvQwHICzGN5f17eSUspDgRbs
	 jbHvRzdvmBTmItTYrR+ltBGRUnNKA2R9TFizO9raGahUL9tsGCTnDKRon95m/ByxYJhCt
	 sXunEIjEpfX3i4APyqbmgHaPIwm3kWMmerRv++CrVdEEgS4rGZc+GHBqaXhEQC6CuuR4G
	 2bYSPau5FKz1fiQfoetBvMpWzZORGGN+kW38NaHpU7zlLTk3dSjoN4fZ7QiVJ25E9q4D+
	 HlUdDmej6d5f51xoEk1SVgVamCLll6prPNxXTHphzNzUnFPiLA1FX5O6mI8RKa7xytw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=42Gs7+kt2Rgi78czHC7JtxOqLEeMRxWEH0wDlNcA+Ok=;
	b=4RW9SUNV79QM1ZVgbwv3O2EbYR+D821TaKvLJuayfdHl+DSPrIBYYgLnz/NCnhWf9e3E
	 Q1vamfq9poCke1W8UrHyLn47OxBv8N/zK2ohN54srTVJ90xAGPJqrmS2Kq/DIDo+qjuZv
	 E9uLcEV3/S9e4e+8ZzuplgbZDUdwiHPaKXnvWusTVqDF5pAea00BLIk8gLxnk52nfEwRc
	 aMH/eT56Rpc/c/zHaTTR7LK70yIBXU1aamzJBUBIqwib/pZfTW2UKwiJeAXKZq58GznrT
	 rIxZ9/67CXKDOEHxHh4nm5aUNCPiPMz6K9UvFdU4KwC//u0NqHfw4IawR6mkebXx7BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvwomPFr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E7606A323;
	Mon, 16 Nov 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvwomPFr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2401F000C4;
	Mon, 16 Nov 2026 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794819419;
	bh=42Gs7+kt2Rgi78czHC7JtxOqLEeMRxWEH0wDlNcA+Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YvwomPFr3Dy9WSCTUXhwRiYexIxZeWPNOZRKwjA0vqfPQlD8u2H3Ih9BA+LuQbQ2T
	 vAUkKvnPltWir4szpjNDjLYjJrdeRcXGRAmJsy8SxC87nlJXLe9ntRGmxAtBZ+zerq
	 C8HZktnZdeV/l1EyOvBTBD80nuK9d9iFhWJDahqJhNpWJWvARiiH3tsbh75HbjeaO3
	 CuW6JIBoklYWu0IejwlPgG8nFzDc7QhmPhK0oQOHwhGvsMqYKLxIAZqr78s/rjvH5b
	 hokEF8CGgFxixV/C5RpoLk8uXvDgZ6m1YV776kOvDrJrLc0DxMWpe+XrHTr5K7vjjf
	 QLuwIefE37nPw==
Date: Mon, 16 Nov 2026 09:56:54 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jm5905938@gmail.com
Subject: Re: [PATCH v2] hugetlbfs: report inode limits without a memory
 subpool
Message-ID: <avrFVm-VwMwoBZyS@localhost.localdomain>
References: <20261111130145.96534-1-dennylin0707@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111130145.96534-1-dennylin0707@gmail.com>

On Wed, Nov 11, 2026 at 01:01:45PM +0000, Hungyu Lin wrote:
> A hugetlbfs mount can limit inodes with nr_inodes independently of size
> or min_size. hugetlbfs_statfs() only fills f_files and f_ffree when a
> memory subpool exists, so an inode-only limit is enforced but its inode
> counts are reported as zero.
> 
> For example, a fresh mount with nr_inodes=4 reports zero total and free
> inodes instead of 4 and 3. This hides the inode limit from tools such
> as df -i, even when creating another file fails with ENOSPC.
> 
> Report the inode counters when an inode limit is configured,
> independently of the memory subpool. Preserve the existing zero and -1
> results for unlimited inode counts.
> 
> Fixes: 74a8a65c5261 ("[PATCH] Fix hugetlbfs_statfs() reporting of block limits")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Tested-by: Aveline Noir <jm5905938@gmail.com>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
