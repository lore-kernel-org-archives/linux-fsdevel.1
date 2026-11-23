Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421549;
	b=pDjvBCyls18Z23ce8HWdBRr4QskaksyDB8hlCVcSOH/a+PReUWDvYSWYaAyh1uC7OyNF
	 QKj7yR2MS4qfV/k6MCi+E2bRbbja9WItkHeYgXIZrUqIcji3qjQraIYiCB+8NNN2JlAE/
	 woRdU/ap1kpa7WV13qwMXVd+4b91sLFupsvAHXvblTbtz8TJEeXwzEdw7WXgAYS0ZNkoZ
	 6tG8rr9rqYxodaC80YlGlyN7oZ0mDjnHWwjCy2mUOH6wf6tpfn0XZvpkZBM3B981x56l3
	 nSamw920zYM4BHwhoDebP6X5HiVDqzFwd9XWxP2MSMp7p1wl4sCuk3n0qGZmhJPptFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2szI1ZqQtgYM2qe1Z1F3aOmh0lr8LS1pFbMyBrHQw58=;
	b=CIZuBf7wt6vTXQ6uMQpcOBIKsk6TAaPv9iseaA/gdXAISrnaFnY89TLUvqo3FPkEWPNf
	 4UJx8Fg/9Jm3CEzWu32MYiKTkOozZuvcx+smuzZNOgQ1tuWtK1F5yJODcF9byY6rZpuyG
	 CzqGX8DV8KzjE3Zm5Smh79JkEEbJO3xpkcTmPSG2cXbE7/IG8m7r6xaPJlDatvFP3R3o+
	 7WHIgsEL38w1t4NW/S0nnslbVNkHUECmGdFzcdNUUiUxjh7UrkCcuZneeSdyf4AkKDq07
	 P1kKhOg0iCCmv6P6nx7DjPSk4wzxc7lZ+vqdRF/KrPcEYV1Gpz6x0DhjHPEvjDctgPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="TYuAlc/U";
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2317606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 08:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2317606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TYuAlc/U
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-94960131b30so300707785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 00:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795421548; x=1796026348; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2szI1ZqQtgYM2qe1Z1F3aOmh0lr8LS1pFbMyBrHQw58=;
        b=TYuAlc/Uck7EToK7F8qMvGOp14+Y3Z9Lo2bo1rUhwf0BXJGtH/DG9/KyjSTwYgUHAw
         LQgslvJox3M6GBzEsjDqWUxJSbrlO8Lu1FPNG6yAquVXhkeB8t2RdzhYa1eZ2Xkk14Yi
         gu4GQ30Rx0Edf76fRKnZYFcB03FkhfRtiCdWSc+GKN/W7LDj10DA6PqozQ6UZvsv7o7F
         hxCoNkCWBDRQ58Tv6ve9iSyrQ2ORJHXiZbqvNk7ApWUfFAv2KdaKRoBTmd9KL+KxmLKA
         degB3wsknJY2pnMbbTSyG6xlQfv6x+AgfNL7FBuTz/ntTlMZvmqXeZGXCOgpL8HZaftR
         mT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795421548; x=1796026348;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2szI1ZqQtgYM2qe1Z1F3aOmh0lr8LS1pFbMyBrHQw58=;
        b=FFMIJXKFnvczmNhhI/SHa92ES8j0OYYONa51CuIohLI29RZ+gZOivSrERfJHY7QyoY
         PSnNCAyludeo2zUeak1XLUIrz87FGYJ0g8Ovwa/Anjrc5DU3hjJNRwqNDB5GOSnboDUG
         dhDabLgsDTUhPNKLgXalamHlShEkkkAfHG1VZWkgJXiZGtog6wlfkCwhIaj7b3jUEv4+
         CDeneNZgdOWNI+2ud6UEwIIklkFYVbbAYXcs7cZ7Lxftn6rTQQB9P0Abt11RaUV10dYp
         PxcKEUaDXi9F2oblkfjcz0BS8Jks5diwMQt60xr+OvM1XufYC4iVZ1ClDQTpD6SxD3fS
         O5GQ==
X-Forwarded-Encrypted: i=1; AL+hErG4ecX1+DFMfiKwqvZUij2GwroW9P8knT20/pZT6zf9wrkCv2KU1gFOQT0G526rz5h+8e3S5YTqjg/6HB1n@vger.kernel.org
X-Gm-Message-State: APuU4Z9uo99okb5hLhTKzzXWuIvaeXur38XuPzn7gdEhcxNS+rXVOZy2
	45cRi5mb+JtA3wY9ysSD9BMfpQttrLvTH9CI9MJMERlAL5/1t6AU1dAgFoGNcw7MRFg=
X-Gm-Gg: AZFdTZfjN6RzNEV1GfK4paikVAOB7EcJXbIAB0+5y4yReA3y3WB5zGA8qgehk4njKea
	zUIrWDxuqmeGDUCwy7jQJa7wscVvlvc6vTz0vZl7pSqPKGt14Qm4JSRyGuvBZl1cfmrHPRRyjDp
	Q3luumG+APmxnWcTt9IP+j6wpJQVoPJD9qxNHpyRiCuno5vGT+Q1Bb2Uei42PjySfL8D6xCeW6J
	ELtMalikxuXS3gptTMJb+nqgRiwZu9VI6B+dw1G86s/cgHXVL2H4YpKVFB74uownKzM5l7NuZLS
	Wpxfh1UdkO3sRUJzsgicKPGO++u6Vn+lTW/9uPHsoD9QIMw56apHJpI5zFHCOkRyR+cmQlWtH4a
	TlR6+oYxS4B+daOvT5BsUV5K9K3k4ytmUDrfFv9YYZy9gp3tKb1+9FQQZ+pVTn08t2GZqddcVyz
	4KgRvJ0fBclUwtYVSIkZNVP9AvVf4TaithLPDBmbtvy0+/oY3h8ck5YN7C/FAHrNmvgidQt02+E
	zQ8AQnSF7IAClNGyCWcIsCJchBM5cOLGlKHPG30vmDj5tTchiiGcAyJOFM54hxXIbN1GjAKtr/O
	jVaOx9SgLQ1b6cJaHdT/6CuCn2Hv51kZ9IEEhhN/eJZTehcEItWrQ1trBIQVngzQTkX6JMBS0k4
	aMUUK7r8=
X-Received: by 2002:a05:620a:2956:b0:949:70ec:7e76 with SMTP id af79cd13be357-949ba80f78dmr1737529485a.1.1795421547930;
        Mon, 23 Nov 2026 00:12:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm752293485a.37.2026.11.23.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:12:27 -0800 (PST)
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Barry Song <baohua@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
 <179537313704.412063.6683001223228002260.b4-reply@b4>
 <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
Date: Mon, 23 Nov 2026 03:12:26 -0500
Message-Id: <179542154647.412063.5153407036844671374.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-23 09:14 +0800, Barry Song wrote:
> On Mon, Nov 23, 2026 at 2:46 AM Gregory Price (Meta) <gourry@gourry.net> wrote:
> > Reproduced the hang determnistically.
> > Base deadlocked.
> > With patch 1: -ENOMEM (safe)
> 
> Hi Gregory,
> 
> Just curious how those -ENOMEM failures occur. With GFP_NOFS, we
> should still be able to reclaim anonymous folios (except in
> SWAP_OPS_F_REQUIRE_NOFS cases) and clean page cache folios, right?
> 

Ah this is a little dumb, but i set memory.max=0 to force charge
failures.  The -ENOMEM is basically expected in this scenario.

Not really something you have to address.

-- 
~Gregory

