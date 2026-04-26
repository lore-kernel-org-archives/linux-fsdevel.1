Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859F40DFCC
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248106; cv=none; b=KWtVYQ0Us4TpjxiLYcSFKs43qEwne/IOeE6qnrYf5RkodjA9mYHDZ2dBn4jWxZi8IyIiBHHowkZLrMdvmt8hE+IbSXK1hxQm5QYbq8v9Ak6JI+Tpt7Ldje+Ea6yu40NoimngGYGrpESi/bqtcsg6Yqb2tRn7/u55vI6lWb9svSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248106; c=relaxed/simple;
	bh=m+OcXCtyDOvxnxJBKahNiKM8NtlieJ6bMOjObt0m7n8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=B+kdj/54Uv5SobcW3cL2PtKgYA4udBthyi7e7qpR1MkcD0+QaTOIXGgmE8QF2qm7mF6Bstn7GgtLwekQ6XzhVg6YblCYwCPIVBheffuNrZPh9/Psj/lLD7wnBNxB9igfUXO+6QvFjw0HQBXQSN/og2Z8vDSduP5QQVdaXu/h/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjbZtCb8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjbZtCb8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so6997583b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248105; x=1777852905; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m+OcXCtyDOvxnxJBKahNiKM8NtlieJ6bMOjObt0m7n8=;
        b=WjbZtCb8F2KkTx258M02IMTdboaHnREo5WqpcnNtVrHN6cVu6Ll5hDmprGY4IKyM4M
         rs6hywfA56DJRK+hzIjcnzg34Br2GThGQpgb4lb8ykVrenT7TsnPz5ThBSKTvgRCz4yr
         WSt7QYVCVvsDnqfILnv+YKRfzSJ8MmLQvZqsKWLhJBbWwMaVLcTv73VsvWu+WpvtvrX9
         CHQyZ72LHQTYDdxkejEKqov6FCDzEDsu8a+/+i8HE6eqaeI4Eh+tZHdLM1GZC7WlcwK0
         flMS5Sr+eYtdZRmqnde/9XSNG5eOQ3ZBxl5sfR1MNKjaWgKj29F/JXC0VHVdc1IUtyRK
         Qo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248105; x=1777852905;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+OcXCtyDOvxnxJBKahNiKM8NtlieJ6bMOjObt0m7n8=;
        b=CPXNRLX96yttGuQbJ30VZB7jctJJpKiYK64C5UbqgAPBkMAS4lJjLWncQ6FOwuktyJ
         MAZ2UnFpfyZNS3nELI4AaFhqPFYSCwWNjE/r3UwmCofusZLFZU8yrM8Bu4kmeJ/f4pN+
         y/Ita0rQJZPR/wHFhzUWNKaq6xYjkH7XH9FtUT/if2wgsb6KYQNU3PICiYr0B9vzQOoS
         mv/1gjDB2iQu3LLyvR78bnZBQIAbW/fIuyaZvVXAOOSiLdzpcX5+XlGuYb+UJOjFdPx+
         XZDqdNcqOpn6KfhmS48kUbfY9HbKFBG5foosAkGax8B1oKzs/UW7YLjPH+9Hn2oaGOut
         n1IQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Hj5ZfvWWq2kd4ocSEbGsPVVmnThWYrv2r+3HND0sB4aM0n5yzR7tepUGH984KyA+PHnOKF1wv7GUjwgXc@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiVgknPFj1tbd/NmKwvGyuaBhiNQ1ubwridYK9Yvzc9zd6P0U
	Brf3PJq07C+Ig2wDf7JFMmMVIHd34gxzuOHBIBMdpIUJgKEvX/zflwrZ
X-Gm-Gg: AeBDieuA67+1Oam+yu0XrBEPFXo/IfIjAZ+Sj3o0yd5dI4ZBZ9rrr7SXhrdM9lUbrPQ
	yzi0vWsv4E6qhPaKi9M4CcN30qXFs8+OSEbNCx6CyZ0e3qqUTxZcKKelDcZWXaymP58BfsL1f3e
	m8E4QjMPNbUHWvHzSdqG6yGHUeRr6M1K2eehHKV956aBIlz5E8J0x/S47QI37BXwNqkXXAAsIzf
	Ya2ZbCFVBN2dlw7gGXTYqs5zQd7UaevWiPXuozpwUhrhhWx3mfqcgDtqQUbXyo8Z9vp6OFQK4vA
	nH5JwJtCP7CzXojnFOpMdWHwL35qYY6WSUM/jLF6cYcSv5uWmKOccqhWc7BqUwC8iqNwQfJZDlz
	s0XjA2LoUKdv+vfkUsRSs5Hhlu4UHq7yO3E6kSb+mHKj7D7PLM07GHncLAKu28pFPw6NApX5tUI
	YFK1lB44ijF59dc2wKfhESSK66OXWbmZI0iPuzDD9UvVQ=
X-Received: by 2002:a05:6a20:1588:b0:3a2:d629:16b3 with SMTP id adf61e73a8af0-3a2d6291cbemr35605566637.34.1777248104974;
        Sun, 26 Apr 2026 17:01:44 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm37959290b3a.10.2026.04.26.17.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:01:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH v3 3/4] testing: add nfsd-io-bench NFS server benchmark suite
In-Reply-To: <a1e784d7006fe5d4331d41a0638be117ac67fb21.camel@kernel.org>
Date: Mon, 27 Apr 2026 05:24:15 +0530
Message-ID: <mryps2fs.ritesh.list@gmail.com>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org> <20260426-dontcache-v3-3-79eb37da9547@kernel.org> <20260426053455.4c06140446976964e6fbb8ab@linux-foundation.org> <a1e784d7006fe5d4331d41a0638be117ac67fb21.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jeff Layton <jlayton@kernel.org> writes:

> On Sun, 2026-04-26 at 05:34 -0700, Andrew Morton wrote:
>> So how are we to maintain this?

Maybe in xfstests? It has tests/perf/, but that just have 1 test.
Maybe others can tell whether it make sense to maintain such fio based
performance benchmarking scripts in there.

-ritesh
