Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257937;
	b=h2THJgoZ7XqzNy0SJQhgGgEeH1olbyCbbGY7subTzIieFp8qgk//B/Kuiwr9m7jveyCr
	 upoai9+J1M/anLHjcS5GU07ccp/02EpzjKc30JOzj4uDRWgglHdwX9dFsJIN45/DJDllG
	 pp0uwHXgRGfGGO7HSole2y8qt8WheR+yRWQHc6TY7sIrce8YAF+XOZGLAjSR9wOtqIobf
	 N6+wiHwcW9QgeLRpTtAz+LoeS3pz3X8JvwU0jqtveeUd8PzAxL4a/QYJpc+PpAkRzSoyG
	 6LzzpXIHIe2JukzlRnq0nbRfSG66zpKqMkG1joEZBCwc6Kk9D40GOJWzTlVlfvVzGZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q3Nd7r/hqjSFpCyfHdGuJldUGtTV8w8XJqRuLAQWCn8=;
	b=vO26ptYlys4JP8t1UD1fcifZvmdIf46u2McjOEO+jcrTi8eepyP9kLKKOrPDEG0G8pxf
	 OP2uwctTUp+SJV/TH0DrXY6ylf2EijQZBRsCCE3G8JaezrXiWds7hFcLjO13LRCmUKn1b
	 ap+8PFZtpx2JyCuoqtj2SKCXKK30R2oCsNP0IIzLqUz/02/0VYAxHVSvUnR/6ReKWHO1Q
	 YNs4SJwhScVJjLkUDVqr0b8AVpMhgt3XQ1RfVIxmxULMWLC+rt5nKEW5vsVSf8KZva58Q
	 bGycx2ZQ1INv9CXCrcDTAZYCMXcUraNFzxSEW7X+4NEFv+KWHj5Ne5JBqSfE1hbdp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvVcgnyn;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913BC606A31D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913BC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvVcgnyn
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so1309427a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257937; x=1793862737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3Nd7r/hqjSFpCyfHdGuJldUGtTV8w8XJqRuLAQWCn8=;
        b=GvVcgnyngqdsNPwyskdRKlVlUbkrSTdOPrGYxMZAS2S/XScGHofnWSOhMduYvMis+3
         VnB8W3g3vQn3VyeOVMepuFtITdcQ0uLQLVxEaHLRiXoeIAN0lkeaEI4LdzO/n0ObRIPy
         jHiTgJmGBlFTpi83NHQUadPadCGf/3gn8/nP1ks4Cz5XhAr9jrIlEOeykUzqjAHmHwKH
         TF2FSgb58GssGgItd5ZVpR6I0Iq9PBa4r4PRtme0OOL0cvmUJpn3DjVGMefnCYvwTGaX
         elytMhXW2ATkL1coiHEU2gM3PcMzyzxvY9GkCcaO54+XqIwuiK5ySZqRqyxeCuFurkRf
         jIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257937; x=1793862737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3Nd7r/hqjSFpCyfHdGuJldUGtTV8w8XJqRuLAQWCn8=;
        b=hS6toYQUZdYD0+5UHbw8icj/6+rIC3+4F/7fVC72SIzruSQujBdc96maSDC+9CqQYR
         Mp1xhNxnOwaWzy6NxWVPaPLVNPQGTStSE4dkXrV2sCAxFCNNNgWWMOyDrbVQ4V+f2uPa
         qvpG31sHE+hcitrRRD49n1MqHefixYxcYmGsjZpIHXh+LZ3sVqzXQHjw2KMd9+l2NxPv
         B0pfoIMlQT8QjdfTUid6X6FstvPwsGyg2CGKNoZvOEOiNHRsOEAUsy//QvfWzKe69sWL
         sba+k1Xux5+cKQ2Xkp5u4WWFbNgiWPMruJ95yk/6c/e/UQNOZ9KsvhF5szOBwQ4h7kYr
         e20w==
X-Forwarded-Encrypted: i=1; AKwUvBwwIaN7mqCqN+s2Q+aET8q1+hObjZKl7a1i3o1DqtUhValjWS1Iqi8xF9COKYZ1OtX7vYLlbF4x8aThIf/7@vger.kernel.org
X-Gm-Message-State: AFq9FYKue1H1jRxUzLn+S96x78ilaMk5jdzrLGSbfTMqjYkgpurB9qCW
	zWUmZkIW2T0ijdDfilcqqRg9yf5VSKolRnnwGbZzQ2qH3eu661BAz7vs
X-Gm-Gg: AYBFou0OMQh5NqJay13oTPY+6IHGj9iekJkKIk2hBiXGql3uwwr5tIEFoB27rY6vesa
	0t1+52611lH3J8FlOw+kVXuA9q4A5ubt8b7pBh//76q1upY6zVxanQg+bre/Z3XsyoBHF87E8Sr
	8Ckr1X+GR86/bGzDq8ouEA4+O8N/5hmNMZAUgL8AHl8IAsA0Uy+unjgi/aOOPceRCB5uL9eF5yu
	W8DcJkhTkbGkLCWlScHNG3XUvMrmBKSoaSkZZ2/kS5FeMtUWLqle1PK5oTl+P8V8WRR1HYzBD6u
	3zddPL/9yQ+uiUJE2OtLGnnu69IuGP3ezGLhLQ4MxDbfZgoaBvbz/duFg6+oK20D9SIWYve+JG6
	RhcpsfpUQYYS5WOAfBleBaR90xdvrOQxNjUDiwXx7lbe7/54KPTys5z+jC0jBPR0BxjNBGwPWQB
	7Zv1/Ha0U6PxzBd3JgFxPjlL1N8UNDN+1JOu1H2UEWDq1x4arOfIJ2RO+up8b4yHHyBpgBSsLio
	T7/EGPQ4ux6BkmGdvhx96L/XCG96RgtQviRs6U2S+FaASxemYE77Moy9sjEo7DvJrcXrCwnEKq1
	kJ6/JDSMMCcyu+QuNelloRtA/Va6+fawz4bxqPt2A1L3GwZ9pdv1Hg==
X-Received: by 2002:a17:90b:3c8c:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3ae5819e58emr3799149a91.18.1793257936864;
        Thu, 29 Oct 2026 00:12:16 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6f01e8a5sm1180018a91.0.2026.10.29.00.12.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 00:12:16 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Thu, 29 Oct 2026 15:12:06 +0800
Message-Id: <20261029071206.19059-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com> <20261027065723.66564-1-trilith.zheng@gmail.com> <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev> <20261029030511.12004-1-trilith.zheng@gmail.com> <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
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

I forgot to mention the tool execution case in my last mail. Those
microVMs start, run a small task, and exit. DAX is there to save
memory, but the vmemmap is allocated for the whole image. A 2 GiB
image pays 32 MiB of vmemmap even if a microVM only reads a few MB, so
for those microVMs the DAX setup can use more memory than the same
image on virtio-blk. That is also a case this series fixes for us.
