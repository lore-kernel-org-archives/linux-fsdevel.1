Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F2372EFF
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310240; cv=none; b=Rb3ZrY/byt4L0zFHVz/FCvFLUHErPOy9bKJSUaO9QhxfyAXI4kXzrhrZ40/pAQpJO2Ot8Ds17KGCVXKeGxz9kK379l4sVnjBUUNx8+MpZaofBwRnLUBuKnbyGL6hP0AAIa1ygr1BykKhR3koytgZ2Xe70FEX6U/qHCHJgDyh5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310240; c=relaxed/simple;
	bh=0hEAxH6OSygPLgsPWvuM0zul/qd7ww1B3y3E3CXvzOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OubE6cgCc6OWSMxluVUrQZ2vAwSkdWVw+XmlVIdxz1CuZjT2KeOtbFMhv6m95k/xFfn8RPZZBLbK7xBmE1AHd6Qc9pXc003raQKfRoJKqEfiTwBbCMVsF7ixcB/8Gv1zCx7wzmEkGGeAwgPIEEn5k9Sejf3Q3q+kSlJ6JDSKHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XGeFG2dq; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XGeFG2dq"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKOGRT1521285
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=vWEqqBLqiHXKQCYkt4eI7nkTUL
	jtzTI1duVNgJdotDw=; b=XGeFG2dqy2N3gbIr20V1uslI7BA0Xd7pIYogyLnBlz
	qkv1ZoJ51iFNeUnZQ28voJfms3i4J/xG9Tvp1XEbqtuozNf5FBh3YiYb6elAwEOO
	+hCbUDddgCRJ/VR3ZMK5N43M8+5idUDk6gx4qOh8gFKwk8POVXOLDeSdcerGQURV
	FE/WTX+yuXoQMuVKi6wNqn11InNK3e2fr2M5xf3AXOmFjJQlgZmue0e4cGHQ2UIU
	5D2xKBrlIa6jswsRFLypsF5wkuPt20fND3ldlwfWHeQy84NvgjOjIpXsQMC9/se+
	N8MYZoxnljImx5MDYxvXHPblaSdThVHR1funfYxh9DXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e9avn4t51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:31 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90d7b3406b2so1288373785a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310231; x=1779915031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWEqqBLqiHXKQCYkt4eI7nkTULjtzTI1duVNgJdotDw=;
        b=aJDS6yXFMDz3erK60CBNo5szh+cMTGGnzVO8d6dFNl07BdgB3UNVqn0wdI2J1i6RyT
         2AefA9t4tMMYavM/6ozdLf2IT7+3KTad7dleKyeN0estafPrrz6ZkMY9u2JCOVQuC2DA
         iG9BzcvOwaSic4xalxEPSEGnQAPZiIbOgRERi79wxVMSJxzX7rSh5gBMhJaA2oEmD2Kd
         JbRSbN9Ez0F160EtS0FX1aeBwbMlZLEU/N+oP0NcbmJv1HckinEDGjsc1t9O7QaNqmsp
         2ReP1h9l8SBWwGrhnWZDmpiSd5fIgD9H02hkCE1HAdPUb3HympeYSGrhZapOt7yFmeF7
         s0MQ==
X-Gm-Message-State: AOJu0Ywx1HjI2GG3p7VPwHzC+x3R8nGIlqW+4u7Bonx2LBSkux2hgIWF
	ROoTnFcVq3NhW7C+Gu/qzcw2UjloUtl4WQU/xyx17rNocsMYy9gbvvPEC4hx3k7zvpoTjWzFhOk
	qijxl/32DMncOGCZbteSUnioVL2HzGklgYKikrrR1owgnzLpgruAZgcyyEdSN9fg=
X-Gm-Gg: Acq92OHsTldbbhblb8Vo4JhWIEyxXIyulFFsJsvqjZODRSLot5T6Q7CuHjbMFU/zXSN
	e9ffuHX0hZrxRZ7Q8VKCziBZNxfMuI0aALn40DY8Z/U/6rgOZAENhmh3ciP1+TAk1fj2WVWAt9B
	2+0pFG/0MLRvzKermFVY8JpHkWMhY+djENKuRev2Iu6fPi641pSOIZugNM7VaVSWbQ9gNLByQoZ
	njK9MrbeiWxFd4vFV2v4LkseZyR8J69mPxPaBOPzaat3GIw2KRZ55nv8PJIg1sa8TlOIXZ0hhLe
	u4tEtOK6kpI37cQknhTO+x+RlzVqNUgUooB87mu+jJqxxZUDYuzIZ0xAnkco9/m1aoQkxlkiNvl
	uByA+appe4ykew0TBK6g+AxrS5wp2rCwFWqebuTKvrrgQR1N0cKAEiH5zwcGnONRU1M8=
X-Received: by 2002:a05:620a:1994:b0:90f:9cde:9781 with SMTP id af79cd13be357-911cdf4e848mr3838243785a.14.1779310230861;
        Wed, 20 May 2026 13:50:30 -0700 (PDT)
X-Received: by 2002:a05:620a:1994:b0:90f:9cde:9781 with SMTP id af79cd13be357-911cdf4e848mr3838238585a.14.1779310230349;
        Wed, 20 May 2026 13:50:30 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:29 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC 00/11] mm/filemap: split out folio wait and VFS code
Date: Wed, 20 May 2026 16:48:51 -0400
Message-Id: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMeDmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0ND3bTMnNTcxALd4oKczBJdC3PDJNNkQ4tUS4tkJaCegqLUtMwKsHn
 RSkFuzkqxtbUAjO/UHWQAAAA=
X-Change-ID: 20260511-filemap-split-871b5c18e98c
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=3123;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=0hEAxH6OSygPLgsPWvuM0zul/qd7ww1B3y3E3CXvzOo=;
 b=NI+xM1sj15FzhmwcsYKgafgGq17ATxKLg9pL8kkBXvje15rDxNOFgGPrNNnyq8u4PLDHh0Ztz
 uvcMqRkQw3SDEKwQl4Xi/ayhWnIis5Q4rM7dUmjykLQ6nMy3iE8z/p8
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=S6TpBosP c=1 sm=1 tr=0 ts=6a0e1e97 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=5qPNtsZOevHdRsu6XPgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 0kayF1lOU6jQTQuOACEyMqKE2-GFO2UZ
X-Proofpoint-GUID: 0kayF1lOU6jQTQuOACEyMqKE2-GFO2UZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX64Om0bqJ4W+i
 Yfw0vg+PD6RaNBJasp3Ekn1k80PtTsb5KyZ6U1B2kDZBk2qvhcnojeHjb2qvjCRKu0d32DpLFT0
 tGG3k3dX+cuK2Zl/Bs9n9dUIgWjq+pcfHBBdOsOHzKuECug2poaqysNQrJwf57eWyauZAaoeSmi
 edyFVCXqmEdsCDVrC4YbidT427vcs8yHqs6t4swqFPeDN5cib5qi/J7RRkW2CLH52t7U/WfhhgV
 Czk40PctBKJ7Ye8MrhHlANfTjUHwWfCpAvLX/q6MMyHEIlSCeV8LkNTmPOqCZm3NsHfexVYsZCi
 Xbpd1Aucg9sp75IaCxoMpI2BCcj2n+5hvVg8hRtaJSzXCTIKAI1nRxFfYagVIpQeShYDLFTfgYj
 ftNHl+MHMb+w1MC8tHHViJPHkTWA8MnCsgjMBWo4gvM8raWHs4f0WceXluXWZq+vLVO1EFKvtoh
 S9J/H9I32cqsdwvqLjw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=10 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200203

mm/filemap.c has accumulated additional infrastructure over the years
that is not directly related to the page cache. It is currently nearly
5000 lines long. This series splits out the folio bit-lock and wait
queue code into separate files, and moves the VFS-level
generic_file_{read,write}_iter() family of files to fs/read_write.c, in
order to provide better separation of concerns. This also slims down
mm/filemap.c by ~1000 lines.

The folio wait infrastructure is centralized in mm/folio_wait.c and
include/linux/folio_wait.h, with functions moved from mm/filemap.c,
mm/page-writeback.c, and include/linux/pagemap.h. Afterwards, the code
is cleaned up a little, with functions and data types renamed to refer
to folios rather than pages.

generic_file_{read,write}_iter() implement the VFS-level read/write path
for filesystems, including support for direct I/O. These functions and
their helpers are moved to fs/read_write.c, along with other VFS-level
read/write functions. dir_pages() is also moved to include/linux/fs.h.
i_blocks_per_folio() is not moved from include/linux/pagemap.h, as it
requires folio_size(), which is not currently available in
include/linux/fs.h.

No functional change is intended.

Note: I have additional cleanups to mm/filemap.c ready to go, foremost
among them centralizing on the filemap_*() naming convention and making
the exposed page cache API clearer and more consistent, but I've split
these patches off from that in order to avoid sending these logically
separate patches to ~60 maintainers.

---
Tal Zussman (11):
      mm: add folio_wake_writeback() helper
      folio_wait: move folio bit-lock and wait implementation to mm/folio_wait.c
      folio_wait: move folio bit-lock and wait declarations to include/linux/folio_wait.h
      folio_wait: move folio_wait_writeback() family to mm/folio_wait.c
      folio_wait: reformat comments and fix alignment
      folio_wait: rename wait_page_* infrastructure to wait_folio_*
      folio_wait: convert VM_BUG_ON_FOLIO() to VM_WARN_ON_ONCE_FOLIO()
      MAINTAINERS: add folio_wait files to MEMORY MANAGEMENT - CORE
      fs: move dir_pages() from <linux/pagemap.h> to <linux/fs.h>
      fs: move generic_file_read_iter() to fs/read_write.c
      fs: move generic_file_write_iter() family to fs/read_write.c

 MAINTAINERS                |   2 +
 fs/read_write.c            | 358 ++++++++++++++++
 include/linux/folio_wait.h | 183 +++++++++
 include/linux/fs.h         |  19 +-
 include/linux/pagemap.h    | 184 +--------
 io_uring/rw.c              |  14 +-
 io_uring/rw.h              |   6 +-
 mm/Makefile                |   2 +-
 mm/filemap.c               | 993 +--------------------------------------------
 mm/folio_wait.c            | 710 ++++++++++++++++++++++++++++++++
 mm/internal.h              |   4 +
 mm/page-writeback.c        |  66 ---
 12 files changed, 1285 insertions(+), 1256 deletions(-)
---
base-commit: e9add7501ad3297dad9b90ce201266830a68ab47
change-id: 20260511-filemap-split-871b5c18e98c

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

