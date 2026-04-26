Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166237083C;
	Sun, 26 Apr 2026 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777233583; cv=none; b=LJxYrcVg1yDsWDRjbKmPli6niRLs29tPumP34hSVaRpGSNedSuWX3LjxMJU96WS7UVrAi1y2i7u5JbPZh/kc6Qo72oBjtkUTHkWkDgDwsntGsEMOzy2UF6nzM1R52/wtZb/StwWA2YZ7mwgSrv6aiVlBGLCxsNAeVFlMX+Dc988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777233583; c=relaxed/simple;
	bh=sQS9ECYqFOsLOgzaV8hLZaILKmDan1UEbRlzXl0ooNw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jNNtN9xPSuR51tE3Bc1T0bwmxrkT4xnOB2rIcul1BUkdgGtx1TVTXIDPx2K+FaMIji5CZ1Ym5HXhj6lrpC8riIE+S77cJV28DkDkwjglEXHesjWwK1yURQXrdGJxaUTksErkKgeb8baTjY2sbMpcPJrPmpMChc4+b4QXgclX7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lZ8ZnK/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lZ8ZnK/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A566C2BCAF;
	Sun, 26 Apr 2026 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777233582;
	bh=sQS9ECYqFOsLOgzaV8hLZaILKmDan1UEbRlzXl0ooNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZ8ZnK/Y14ogo/bQCAeGfOtg3ocivHsmkLuiUhPVCqMIarhhSFoMpeINgMrMFyNZB
	 r7g2c7ISOz2x/JUikftn8t2e8vw7ceqpL6UnCWbvRqAnxKf2S0SGjhNmAOFZ3wi3yZ
	 WzcGinpVqsoCQ6Ldq7MwMOSQ7R8iLn8Vqdi27H/E=
Date: Sun, 26 Apr 2026 12:59:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com,
 willy@infradead.org, jannh@google.com, paulmck@kernel.org,
 pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com,
 richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps}
 reads
Message-Id: <20260426125941.9921d585e2c5033e68ddb9a1@linux-foundation.org>
In-Reply-To: <20260426062718.1238437-1-surenb@google.com>
References: <20260426062718.1238437-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 23:27:15 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Use per-vma locks when reading /proc/pid/smaps and /proc/pid/numa_maps
> similar to /proc/pid/maps to reduce contention on central mmap_lock.

Was the benefit measured/measurable?

Sashiko doesn't like your strchr():
	https://sashiko.dev/#/patchset/20260426062718.1238437-1-surenb@google.com
