Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546A1714AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079520; cv=none; b=XBv26ZYMH9ot00sY1QMeOQzhMcrFhwthLH2w2b7MSWKH15KgWwQsepHvbJdUXA9ReBIvxVNKw2pEWTqFPLc8KhSvRpX2qUTdzwLa8hb1k6eB/o45izOya3MDMwfaigiutsYddpmBCB8pv3zaGKPNMjg1kCMBFcz9ZmDZe4AjajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079520; c=relaxed/simple;
	bh=gXeS5SuHZYMUemKHOmOz16PUJJbPCl6HIOi2g9LM3eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=myvFbQSJ6Hda5mEkd3/7BM3DyKN0NttJuHM50WXVfE524RgV1+7kijpItFXkuoFoDNJZGdvdyYFdehug0SKloJaRRNldFkHEyTDgdeuXEO1oWWN4/N9HGQFxr4oSkkb/p684B1c+ySS2K3rMMzCi/Wi09AJKUSdJxHY4ehHU4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvAdR0xh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvAdR0xh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c96c92c0980so996611a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784079518; x=1784684318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hem65AM0p1NC/6cT8RtuIc3JMoV2gP6hDU7Wj0dcXF8=;
        b=jvAdR0xhCdwt11TVEHQIqWq5bges7ldMFzfOuAMdrxu/8NSEpONDLRCRPSVCWfE9t2
         L2CsxBXwZ7gZi166lySBTD4y7z/sI1Sd/Yzje6w8tTAEyzJ/ZcA/JSeOUmLTRTkabb8k
         JQvoHQGK+Fi+6x4iIRfDLEFd2XGV1FEzfUMa2mTh/A4HsMeumVDPBtE/hX84OMxcAE8c
         ZFeXlXdxX4zsoV6SPITmBCwEJiC7CSrX+hH4iSruyiUxUniVTgZ107MSzCBK2ZDVTTAP
         7S06FIYQhWArkIPplaisxdkVCLiIcEal+zghY98KiJw4qxzD5L0kdh/4YORjiBe14Pv2
         Eesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784079518; x=1784684318;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hem65AM0p1NC/6cT8RtuIc3JMoV2gP6hDU7Wj0dcXF8=;
        b=dqKM8NvECNMXlD5TXZjfLFqTqIgmntmmoXwrQt9W0HQbs+QscTCw0Ku2nQ+4gnzpxk
         EWNousQpIvbabgAMZYn6rl5ys8QcdynYl6W7XMX0Z12W43K0rLhLpcFF6OXQoNwaQ80l
         SGT2tSoVghIQ8pj8WdeoPJPHkQVnuflo+a2rrZ7E1ee8d/lLkrpMyB+lkUVqzU8JWu4t
         AfWh3Nz95kjYUGH9gUJQbJhT9YqvhTBYdQ8H7SIdgEKNE+yvk2L0jwTjb+C9vnSZEIPY
         arsMYIu/7g+SqC2XCcc2oEcg7api6KBdcPfxjHE/tJnZDWfnA9TiqDOVF8EF3WmZYrUu
         taUA==
X-Forwarded-Encrypted: i=1; AHgh+Ro30rLD2sztCAN/s1z/4lHO80NNPIb5NyS82le8J0IlzeSRNgqTquuJF4O4Bvx+0So8k8G5Rf2O4fE5nSdt@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLlFdbsHqkGd6FYxe6W2QqcKTNMfcNkcRv64+Qp123Ll3JJtn
	/cP/yUZLOmQVE5qabZOGik5FYnX4d7yRh2LsJtB9YiiAAQ/QPRyqv+hi
X-Gm-Gg: AfdE7ckNc9s4Kid4R0aoK/ihFKmYrjVzPsvEvDuA7gSQfNjPfX0yWqHeyDjMNM4wbbq
	uFrZV0yeLraN5eDTqqbvS18z1dBRG77KKIkHmo5D8bFXRM3pEI2vUgqeDORt8LN/PFA6XJqW6KG
	w8AbEaHnuc5mgsRUbTdFjk8NtoVnVZAoXsw9in+3lxecCYQRLRjnuHvESi0YeE9sBL5sA8UcYEX
	iWdDZ6nuPZd0WzLc2SiCbG79vdy8GfrKlg4auM50seTPwQdwa93K3YV4r5lTqKVHqHOnXzNU8es
	jNLyymClWOE/rRkm6wvLPoQ91R+46TAw4OW1pcYzPlqjN3jR+P/wcisIsmlWq4nPcVfX+cTELM4
	oukZ/GNltF02uHs3KToWUry/3VW7DbSomnnaE7bu1t4LOw9nwYPvH5JynZ7jJxhfSmr5Im3R/o4
	dshpFpqq/PEvfINV+P9DQ=
X-Received: by 2002:a05:6a21:694:b0:3c0:9c19:b27b with SMTP id adf61e73a8af0-3c110cf96d5mr17213273637.73.1784079518369;
        Tue, 14 Jul 2026 18:38:38 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm11080617a12.22.2026.07.14.18.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:38:37 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	usama.arif@linux.dev,
	lance.yang@linux.dev,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 0/4] ntfs: Remove __folio_index from ntfs
Date: Wed, 15 Jul 2026 10:37:59 +0900
Message-ID: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=gXeS5SuHZYMUemKHOmOz16PUJJbPCl6HIOi2g9LM3eo=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqVuRt1iA9xlpg5xY8cuf+kd/BfQGrnrgHRV55a
 /02UL2y6tqJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCalbkbQAKCRA08jD6945I
 02JPD/9/9vVI31TlxScuAhGjQtrA6ftuQgHF6vnegnnO6uPmNa70Z+hYXl9e7RCwZ9dmt/B18vA
 YpOqfr9J57JBPM/zJ2/JR0imw+dJlJAqoCHIf96uVHVCoWVg8Mp0fW6G3V+UbvWhNY+TzoinZ9D
 jfVE+12mckjY13MW/B47V3NEw7gosPgo6IZwwcTrHdcj4SJxMp1VZ2hUiqeO7VKd23JhoBBaqYE
 MQHRCdchCgP1cvLW80OZrjyPjWXroIc/rNQkkfWNaTXE/8lw3K5z7GkK/NKW31u7tRsI5AOUGyL
 rVZqfYqi1ipENUKn7kRxVB+gbn1oXTbbTpqf99Joc/unRrl37sfyaENagk+iEC7GbeHPriHYJJT
 uDaPgyAFkToE6M8lPJj3fXSatZ6/GeBuNx9psTalr2pzJEuy9ckWzjJVrRh9Lc4Jwfh97LfCxob
 rsvWhL30Ot9bfrT/Q0MpdVmLV0jRLZQv3z4/SgolQdndRTfiCfWvA9hmcaz3y2zGDYr8jTfUsVE
 xyrOs8eRkP1hWcCf+e5qwIdTtJdJ21tMfGsFd4etwEfyDAgaAYlN5L+Qs6rA1M1i3vIDBuFG1Y7
 PNNpXkxBVHiixgWKJYTF/+gKqwMIIR7aXZCnGjPc184qZW77Pd+oMx1UVCszsTk4PGHCitrUujC BVdjjfM25ZmfHCw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

This is a continuation of the NTFS part of Matthew's
"Remove __folio_index" patch set [1].

[1]: https://lore.kernel.org/all/20260608210618.3437216-1-willy@infradead.org/

To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: ntfs@lists.linux.dev
Cc: usama.arif@linux.dev
Cc: lance.yang@linux.dev

--
Changes in v3:
- Patch 2: Fixed the boundary check so pages straddling initialized_size
  are zeroed(Suggested by Usama).
- Patch 3: Rebased on the top of patch 2.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Matthew Wilcox (Oracle) (4):
      ntfs: Inline zero_partial_compressed_page()
      ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
      ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
      ntfs: Remove references to page->__folio_index

 fs/ntfs/compress.c | 54 +++++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)
---
base-commit: 0ebe8f625ab0520217a425d7cd366e4670484941
change-id: 20260713-review-matthew-v2-e06bc4211b3e

Best regards,
-- 
Thanks,
Hyunchul

