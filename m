Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFC39D3C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314435; cv=none; b=csvs4jK/IPsrY0cofI6wDo8JK7HZUKqNyiilvnVQi7/RS60DmHchHTGJpAH77RTVVvz2zQ0R5EVfdUAoKRZgKUtt957kjsS3JY0gLmH0fKsTbzVZdDv+GRY3cZbkk8JK0nGlp3jzldVkVBQilFvLw/4LYtGkk6LU5UgIBhH+Vg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314435; c=relaxed/simple;
	bh=Nq4i7Nmp/tdtJVsnvMBVbqxNXwHWcXIAAz3MkCdAHLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUjIkPOS5NvqzB/baV7GyfYsO+Jv5elIUxXzUlinAUUjGcTzaVMshmWKuMyTxgQdIscQl9fC0KR2I9s9EW/1BynaU7vmG0TxfB7QRJXoQTKTbTBRSM+PvCOe0Bout3wjbZ9vpvQkP2kOg0VhTTeQHqqQy0RvfEZhyjHc1P2kQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com; spf=pass smtp.mailfrom=modal.com; dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b=Q17yYidT; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b="Q17yYidT"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a3490bso444300b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=modal.com; s=google; t=1790314434; x=1790919234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+ukOysD2I4kW758/buisnZ71NIZ/Yakkkc+BM/q/w0=;
        b=Q17yYidTf5jJss4wA+kDIeQaS/JqkmN6PNcxbpbAwKPweGH8FzviLYptkcChlREhnm
         EkSIHF+gQZlZbwhhEKn+80ABdCW/mbLH74dkS8VoXu8sCXg4a7Cy+HT+S+epLgk/C8AX
         TgV2rxO0k+YU3ySLZWJjYU+TVPDX6dyQclHReFblzA1DnZwxLwbUDR5Xqn9sd/c/cf1c
         a6DddnVPj/G4LGx4ydwW6DHu4shFpwKXdPIpPBQ8si6BoSII67+MgXXkUK+xnZBRofu4
         /ZVxcPYlbU1K2hO9Prf7Wgm68FJmxjNtgUhoA6GU9yGa7QAFzQsxPxiA8nCMSV4raAVq
         ndqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790314434; x=1790919234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+ukOysD2I4kW758/buisnZ71NIZ/Yakkkc+BM/q/w0=;
        b=egLlVIJ9DXMmkMZ+85rt/zckWuG65IU5YvauOTjUPFUq0hzE0Xc9sXF5QBjihU16AE
         8AQTBTlZfB0p+yQDHSn4j4cPeDtgxIxNMYgu4KQhB0ejiuQ+I9BAXJx4HyqlKqyrVfo7
         x5klC7nFA/dToNBADfzbvH/eN6EMOw8IIVQ+i6/wZSaB5GzCO5QQwpt2oxW7/CmY2hkz
         AbCcAFu3HMNdblHdy8nsbPe8kWiF+Yru675krL9N87pPQfqiFTWY1noVqu5skcrtWNp0
         8najaaZTtS6WGhiriNpDWYxLbIhdFa/igVzAKCWKveXEBv7PEbsc1Aw4KSHo2HPE2JSr
         /FHw==
X-Forwarded-Encrypted: i=1; AKwUvByd1tBkf7Tevkn9b0DdcZx1tbKoUqg8k4aZm35Owl4JDOkr+XmznLdZLa6d2XltKCosnz2BZLCFCM3Uwvhh@vger.kernel.org
X-Gm-Message-State: AFuF++nll60GEMu7OwSBFaVLp0/LGQrEB6fa3jw0Y17k1VMZPBoZVeAz
	UAfNQBRMEzHUkWQ1OeFJk8VexidKmboG+ufvqeN+M9enL4uMfTaUklWxt7b5oIx00Qg=
X-Gm-Gg: AYBFou1jseBN4NweK/TJi+CRhAZ5MdojAMg7k9YYnQno/gG0M59VyKyAbLkb3TlZp8H
	2UKSvjKOrwJHBpYg9RjvYyykD7jLVTI8X4vU5ViQDQyb2zTT2JxR3DIxPxEVB4Yo8TwiPlSlPD1
	UbuBHRaGVPvPJj12SjQvhlqTH7GRzeHMI6Jx8CUyTI9N98+J9ZPZNGROXESWNQwcuoFXEAUPgu3
	BsWMhMc2H2OdmXuKciumxMnZh7tmJ7lz8AcSzpZAvf6O0VuijJWdeyCLiKb4FpfPl+Emcg7/RzI
	pOr6Y0bmo3g+8bwAaafuHBZnqXINgCnZ+wjD7JmIcSvQXbxdyZhO3B/lUt+EBRlr5R09nTe7eHC
	jgKSmypRS2oi/MONKTI+puYuG8SXW7MqToJFnjvzZ4YMdkGxGMJTFY2aw/b5GKY5JjLnfgmJk6Z
	GOIAJ991pSeIaw+IGtlEcqhNqBNEao18SWmzbpJEpZqsJHZ8JsH5FycWKw3VNngic5zi7t4RuoG
	roH4ZCn1+ccKsiMwHgOe46bn0MWtKFIf30zoakJ+uGOQ+TtLMZzyfcQ44RPGU0QiCOG1H51KzUr
	6xGthB/uJ5ymWXQApSggnVVR7pB5SGIyQpCGkw==
X-Received: by 2002:a05:6a00:6c91:b0:878:34d7:6982 with SMTP id d2e1a72fcca58-8802d04f355mr829494b3a.48.1790314433582;
        Thu, 24 Sep 2026 22:33:53 -0700 (PDT)
Received: from devbox-ayushr-01ed.tail5292b.ts.net (ec2-44-242-192-44.us-west-2.compute.amazonaws.com. [44.242.192.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea88a1a2sm509721b3a.25.2026.09.24.22.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 22:33:50 -0700 (PDT)
From: Ayush Ranjan <ayushr@modal.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ayush Ranjan <ayushr@modal.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts page cache / rss counters
Date: Fri, 25 Sep 2026 05:33:39 +0000
Message-ID: <20260925053340.2067567-1-ayushr@modal.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <61f8a9af-7cdc-4979-bcc0-bcc932f7301f@linux.alibaba.com>
References: <20260924061708.1645968-1-ayushr@modal.com> <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net> <61f8a9af-7cdc-4979-bcc0-bcc932f7301f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 24, 2026 at 09:30 +0000, Baolin Wang wrote:
> However, I did previously fix a race between filemap_map_pages() and
> truncation that caused incorrect folio mappings, and I believe this race
> also exists in shmem. Ayush, could you check whether that fix is present
> in your kernel?
>
> f58df566524e ("mm: filemap: fix nr_pages calculation overflow in
> filemap_map_pages()")

It is present on the UEK 6.12.0-204; its changelog lists f58df566524e
(as the CVE-2026-31648 fix), and the rss-counter imbalance still
reproduces on that kernel.

One more data point that may help: the reproducer punches with
FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE and never changes i_size
(and all faults are below i_size), so the i_size-shrink window that
commit closes should not be in play at all. That seems consistent with
your suspicion that a shmem analogue of the race remains unfixed.

> I've been trying to reproduce the issue on v7.3.0-rc1 for half an hour
> now with Ayush's reproducer, but haven't been able to trigger it.

Thank you for trying. Two things that were essential on my side, in
case either did not make it into your run:

  - the khugepaged tunables from the report (scan_sleep_millisecs=1,
    pages_to_scan=4096, max_ptes_none=511): with the default 10s scan
    interval it never reproduced for me either;

  - shmem_enabled=always, and many parallel instances on a large
    machine (nproc/3 instances on a 112-CPU box; it takes ~2-5 minutes
    to trip).

That said, I should be upfront that the reproducer has so far only
triggered the corruption on the UEK8 6.12 kernel -- not on our 6.18.46
hosts, even though the production workload hits both splat forms there
(kernel list in my reply to Pedro). So the reproducer is clearly
missing some ingredient of the production workload...

Thanks,
Ayush
