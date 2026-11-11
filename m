Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371220;
	b=PNLH1H+G8Vo+Be1OQOtJKiPS6GuNAOWlMcDdeAsV8US6bgL7ZfpwCtyvn2Cf2ARKD8b2
	 Pt8fLxbEqqnkqo9xrM0Uu2Uo0bwRka7h8fk90IZgIsKdJKgXHiZ4kQjX18czFGFVqxxeg
	 klZmk1Ub+5z+Jm8WFq7Q3edapm8XY/JaQD3hEdhAFluHK6yquf50iKNYYDZagd9L4hRGz
	 siuTDs0+cjctyxbgJIJJyx19go583x81TUvc0swcy0y22zUa7FkTwThA78ZAFKGs7G69S
	 J1fTuXbkSPH2VxeCz+YR1GnWiXa4jcJ+GQ9lcee8oZ8jtMsC8EWz8WJ5AfwDtU5zopA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y1pY2f18oXgCvPBL0khHJZDCXmLtKWWVDmpFe3/LPR8=;
	b=EoGavZwm++mctKndc04f0ttd2hbNd+d6QGjZvt2n3GRBSFtoIJfiOU6JEcv2AldOtYvu
	 hlPN+NJWZl+G9Vbsoe/EpOw3N5q0lg9uV28XVb9Nik1kyM7sBOgVG8Mq9Cym047LzwjgB
	 0x498+fzvrYdrNRNVk0JkUs8kr3plgmNF8yWRvymi7TKGCEkw97xCkyGPKfXmtDjbpxch
	 9cQaDy5E5BSzOe8/t3LfejVBD6NgPuuEXEt8BLUbSqefqRTnVFCwG954xpdA6tFCKAxwg
	 s5pPhiAmawzIw8wa9xry5KSsFGkSZuO2B0Gxc7Z7oNmYz2nrKLJN7myUjbCQCo1V6wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bwtt81yh;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998B60A2601
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 04:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4998B60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bwtt81yh
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so654220c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 20:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794371219; x=1794976019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1pY2f18oXgCvPBL0khHJZDCXmLtKWWVDmpFe3/LPR8=;
        b=Bwtt81yhvu0wEfGoBjy9Y5Oqf2BwoAh5Iqn0G/PMSPK0uYBx9oZtLjka60IG0pe2Z5
         sV6wCLpyVe0J5I3hux8QBV3gl8DhE/erxeo9tiTwGtMbBPQ88qWVwCBNQ5TOhRGFqlQW
         2Cykqk49Lu/d0fM3PMrg6x6YA3YY1X+lYfSZgSuGbCFzJio3RhljwE+iEXPWamGHD9n3
         2UdtpDL/AqZ9pj9YVK5o6/KC8+lNqSQctnYl7X4nrlNgGCKPvUa8/a+Dr3kKzMNUrHQQ
         gZ/HUE1AAx9Rs6Eu/PWPcUZh7d7WtYukRlfiK2LfEaUpVIZq/7dp4wu1zzp257vIAylT
         7tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794371219; x=1794976019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1pY2f18oXgCvPBL0khHJZDCXmLtKWWVDmpFe3/LPR8=;
        b=gU0sC3AhPL2kw2TEI34nqdP9PFKQo3+bKvIv2iuGaa/auXq4KMX4AsNkb+9H0fQG0f
         +BUP1xRXbv4XEv57dmCHU4GxobQgzmFDxLI5jA2rn/HHV2bOZTuJVAu4flJha3BpV+wH
         65TYbb/wFu56o72gckMNSA5dqZA4U9l3sOY4j22hXTRAqMBB4z6fZsrvS5W8tJAQarQK
         BHB81fByJLERWweN3NSwjzOkZn13B7ca3OAw4F8kI2PtlOinqTDvboiiLnkrVucCgjqt
         f0UySCV+CPR6o8ucUJujvtofW/4KptLofjp+b2CY/PjYhIP9m11rMH6QOMAx/C4vuIbG
         e1vw==
X-Forwarded-Encrypted: i=1; AL+hErE8CIy0LkajyMJZFekSsa/vyMOntjqrxGOirg/nIR2Lx27HqxWBk3YyeJrQ6g/78W63lKt68fiQexOUjH0J@vger.kernel.org
X-Gm-Message-State: APuU4Z+xcA8qs5e6eI8aWCBp2orSzz3FPbnIwGzszx4bCakG8CpqZH8L
	upB4AqbL8hzXeDVuJZOSHk+rE8kswEaT2+uI1s5ZOgI45LqaJpJJYXzm
X-Gm-Gg: AYBFou1rifV2wUl9O7yGHWP63lX2rT/gr8VK83SuyUuocoiIE+WnMOF2CTWbi4421q2
	jFnP2UWr3MEJNSzBHAK9QGaMWQOpDQqcq5p8RN3v+0uX5KJWlSYmwGZMwYbvd+fcJz75h8Gh9n7
	3NhLGy1e86hw6fV94c+7N92CsBzH08owBoGxvajnunfi3sZHzBCJWR/hOO7HAOa76qu2GqkCmvn
	q1CnUKRITyf2RvgIJgLofVbGS5i7N3kKE5yJdnmqwebZHk/yB7/sluLBCQAWQ+bNvT1M4vG3ga8
	QtM0i1+RRmpBCBmMEAric2gKDhODzqAOyIKFQP083jv4Xieylk6oic9/kYfMZ5lNd431rY7VSK1
	/aL/oCR63P55Gfyo7Y6+1ryjupKfQkVYv6hEqkg4xe1wQ4aw78fZEnNukOo0Sk2nhEvtXsL0/8a
	YboW3eTOnc/XmbXIK1P32As7mOe9o+kwnDH5EwY6YXVSRI3ZzRUZnqBwmsaAYTEWt35NyAZzmIH
	tS3hQtaoSHlOiuqDPPZB/0dpCSQ7ZRerAI2ASHDEhU4IZ/A6iXTQGhaFCY+MihD6pfZU4QLlGGd
	J7OOycgGgeFe1Rk8jQCGt1dtFUqFpJ6vpg2Wur1jjTgiVMURE79kmaaIffhLUpOGEw==
X-Received: by 2002:a05:701b:2302:b0:1b3:a26b:8b97 with SMTP id a92af1059eb24-1b3c0353171mr1289026c88.41.1794371219170;
        Tue, 10 Nov 2026 20:26:59 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm11563252c88.2.2026.11.10.20.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:26:58 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: jack@suse.cz
Cc: akpm@linux-foundation.org,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	fujunjie1@qq.com,
	vishal.moola@gmail.com,
	roman.gushchin@linux.dev,
	tracekotae@gmail.com
Subject: Re: [PATCH] mm/filemap: restart mmap readahead on sequential faults after many misses
Date: Wed, 11 Nov 2026 04:26:39 +0000
Message-ID: <20261111042639.191997-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <jwg2p4bjzkacnx6fkifkb5jbe7ah6btuecpcpulbkym6e23v6x@mh35p6yafmqi>
References: <20261105192517.228523-1-tracekotae@gmail.com> <20261109091444.128521-1-gopalmalaviya53@gmail.com> <jwg2p4bjzkacnx6fkifkb5jbe7ah6btuecpcpulbkym6e23v6x@mh35p6yafmqi>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue 10-11-26 14:53:14, Jan Kara wrote:
> I think this [1] looks like a nicer solution to your problem.
>
> [1] https://lore.kernel.org/all/20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se/

Agreed, it is simpler. I am dropping this patch, so the v2 I mentioned
will not come. I have tested Alireza's patch with the reproducer from
Trace's report and replied in his thread.
