Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BC3B71AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733536; cv=pass; b=kSiqMthgBoYrpthSDMujoqrd25fyzd1GY97Jt1SziLXOe2SHcchmvbGLP+ll/BjkhCqtGmQKDdBqOgNJgiKCOdB0M4NZA+of1xWP/1SXpmlnmepUUK6R+oy2DxpcL7Xu5AS+sRrAQrT9F/5D8odP5RLT3IoATO/bXPft/A6ZmU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733536; c=relaxed/simple;
	bh=PffqEXtX/Q5bx+GiyoNLY4Jcj3ZCebkcg6urzE9I48E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tjdNwB9ATF95tDeOajgpKE24R7YSuJEoxjbUo3nOiLhLL0VMlMsDbvs7Ps29lERc8MPChxWcUU/Ewj/jqfk9zaXW+4I0JeLhKa61takY/tjeVnD89/c0qY4mCNkWgcCh90Fhgqa2k7xqoD8wUwL0EIStyzSAxgxf1UEmOKxxJFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyLqoill; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyLqoill"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e7109321dso596758a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 01:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787733534; cv=none;
        d=google.com; s=arc-20260327;
        b=dS4iz8LkIY7P7Qm7sUFHbbf26vkKs+OQ72o3AZQ2hs1CoVloocUw2ONWYju/wWeQta
         IaIeJF1IgvhYANntqGfvr+GUO19OQJNqYZEnbIcfDc9czAsoY6CNEyqAKGVseqBZg4jQ
         3C2GrHnE/fH3VBwrAqEBmiVgnmQEW7qhtZR4wsur+W/xbGR7kD/olNfUSvt36Wc9L+gV
         pVnIXL/97W/NNtfgAwa0E1PVVIY2+m5i5BHgrodykMiZwwsBqdA4wuiztrHDJYzprDgO
         yFU+ViOKvnvkLhHGlXOdyR/sYkBh4R3uXkM1gz4dh8olKkHoM1Nt9U2ryv0EqAMzXIA4
         4BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PffqEXtX/Q5bx+GiyoNLY4Jcj3ZCebkcg6urzE9I48E=;
        fh=N++zANdhlq7CjToIEOqSZvqPQ2JTDjUzaDi3h6Zfoy4=;
        b=iHGl/EPRMCcUhucf8x2yOiyhhTYkbXfo4w+u1VTFpECuiK3nEf6Mff3yu9tmaYc4vE
         47KoEzh5z9z4Zxc4WDRduDBe0z4gCJvVw3M/eDRk64F3B3j8sCQJVzP+erG+XUWEAZYz
         BBW+3AZdLPffz/9DiTDLQfMeZc5t97ZJOs3mcVZFwPZqP3Ve8rIJlYGu2mwoU0TULcxS
         bltYt9kF9j3XDQOBSENSTbdvpNyP2UhyZzdVp7Vu3yT4WBRoDtdjtkMlXEfzIzmbQpMi
         be2q6CHqfvA7m+0+gD8LdXPdyrk8+CVlLfdEEQIP9OdYIIbwKw4Mq6xzge9KnOBwIa+w
         OE8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787733534; x=1788338334; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PffqEXtX/Q5bx+GiyoNLY4Jcj3ZCebkcg6urzE9I48E=;
        b=WyLqoill5/hnz/3v1/2lJo/dRSirWihZmBlZ+2rSLxDeFNG0PGC0h+EsrAAi4bynzl
         Yo4SfbgYdPPcslMguGmP4f4kbKxLgh6k46YEzQhjXnBdwjymRrVZmcBUEld6n4h3Ezze
         lEivBwPgkOA5TsjPbu58DxLduo3YNlmMd76BQVl89itcIi3yNLRphyqtdoMexnfYjyl2
         BDqu09sYQAVYRFZjo+S/NXHrfmE+i8Y22zpF5ADBsU5A7kmBYEvdGYeoqSUlodkKVPgL
         1c23yNG7u8Fshpg3n6aaWqCBqLggD7LfavOEcvSEr73BzJwYOwUbc07SnNAAGtSBz+Lz
         MtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733534; x=1788338334;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PffqEXtX/Q5bx+GiyoNLY4Jcj3ZCebkcg6urzE9I48E=;
        b=h36S7V15Dq6sRMgH5ocfbiS/7sHQfYxrGR8bqEMs81HiNe4o0pjQW1xXCc6sxWbk6j
         eHUJzKaanagOG1JO5eX4ZHcCCEAI3pEEMag/N7c4Q+GeXFDVOml0GG3vIw1YQ4mFWzju
         wX+nx28b5YTmFE6X3wJYReu8I3Bojd0RpcvUocIq5dHyFR875eSE5h5FFAmzsPUmC1DM
         ckw0X00FK3jYI9W/zw4NB2QPD/rNsEuehJ07tyuU2e/+5+i2pOv938yV8pdAWuQDhcWw
         GJF0Ea5gzU1R4BjsRoUquGbt+bFpDZBOeNgP9jTZafVfjmgi2m41VqpIlu4HuT+LMQcc
         5l4g==
X-Forwarded-Encrypted: i=1; AHgh+Rp++FHV088m8Kxl3HAS2udSmOEanCNC/WLuA70nrrQeIZeOcgloftUlPP+ga5UXCsXR1fAzXUF6/8MU7046@vger.kernel.org
X-Gm-Message-State: AFuF++mLERz5nMKlLtq4z9k0dnzpgEIVqm5ibIe9onqaILfisttOQ+/I
	aO+BFCmwyPw6b0WOozL6kr0Mf7xYI8aAxhEPxV6pwBOvYxgIzp3PUeSlxY7Sz41s+n5EJOHg7hy
	0tZ4v25NwTmBFELJ7YLQt1szNsEqmU+o=
X-Gm-Gg: AR+sD12e2zcPf2NSpPJaMCx+Sh56U47Oa9KtPGFcuYhsJIRkuZsuluvzg+QPYhSodh9
	CIi0Pn5zlYYUq8lbyJ4upQSDYOUtzqGzdR/VAmULC7AbPfJZ8whzKCqq6x5h3aKDiZRKhD+fe5G
	IT+X7N97nJ0bn9TCppURzsKNE8NZh7pjjFLP+Xv/EHwJi5VRNgKewwnduwIe7KpuSw7xVUBIKIZ
	dlZox4ZcYFTAQoTaUroRTvz2KrWQmA2cZAIIFOMbycTIUEtrb7bq5Ci9vqulO07ltu5gyqG4UYx
	9w3E9lHQff70BiOw0kh7AnN4vUc9Fktj4bf5DoniCynGGjAYlEyGHtUaSTNGJ/5VtO4nxnBSC2b
	Xag==
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-3966d3dafb9mr11691795a91.11.1787733533907; Wed, 26 Aug 2026
 01:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Wed, 26 Aug 2026 16:38:42 +0800
X-Gm-Features: AcwNN1Wjw1VYF3BsVfww81J7HSWGrU9A5HlOr8346QSUBLudJj3Gk64Vhr4wqII
Message-ID: <CAPHJ_VLLXVUEvOwibDOvHKpVWFkZ+xE8DiLxxnWTwJ-kzs-gkA@mail.gmail.com>
Subject: [BUG] udf: kernel page fault in udf_add_fid_counter during unlink on
 crafted UDF image
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a kernel page fault triggered by a syzkaller reproducer on
Linux 7.2.0-rc3.

The reproducer mounts a crafted UDF filesystem image and later exercises
the unlink path. During unlink, UDF reaches udf_unlink(), deletes the file
identifier entry, and then calls udf_add_fid_counter() to update the UDF
FID counters. At this point the kernel faults while reading from an invalid
address and panics.

This looks like a UDF metadata validation / corruption handling issue in
the unlink path. A corrupted UDF image appears to leave the filesystem in a
state where udf_unlink() still proceeds to update the FID counter, while
udf_add_fid_counter() can dereference invalid UDF superblock/private state.

Reproducer:

syz reproducer: https://pastebin.com/raw/MKi2B5eM
console output: https://pastebin.com/raw/z6SbDFgb
kernel config: https://pastebin.com/raw/AC6Cwmzt

Kernel:

HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)

BUG: unable to handle page fault for address: ffffed1020a13763
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
Oops: Oops: 0000 [#1] SMP KASAN NOPTI

CPU: 0 UID: 0 PID: 10381 Comm: syz-executor Not tainted 7.2.0-rc3 #1
PREEMPT(full)
Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996)

RIP: 0010:udf_add_fid_counter+0x22b/0x2d0

Call Trace:
 <TASK>
 udf_unlink+0x2e3/0x4a0
 vfs_unlink+0x2fc/0xc10
 filename_unlinkat+0x3b6/0x560
 __x64_sys_unlink+0x46/0x70
 do_syscall_64+0xc4/0x7a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

CR2: ffffed1020a13763
Kernel panic - not syncing: Fatal exception
