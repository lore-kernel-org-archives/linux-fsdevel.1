Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2624E4B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435304; cv=pass; b=VxNHnzgmNOaDZ0V3bTj6gEowxaDA7Ulx+sxbKEPCVG9QLwhRIH4Q1nMQap5j4LFYMhbpmupp4wh94dfiWwOHZERMPQHSabh2cwAlPFeuduIWdDn94xZO8hhw2FCaBsodfCNK6kwDNaSlTpLISpPt6ih8jW/Ttzq/ysgSbyd2EtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435304; c=relaxed/simple;
	bh=LoHH6teKJBs5nCLNhn21DjNBFrazrV1QkpnJFe6LV7s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p/47KOQ2iAbvs6giEW9kt1Adygk6ACKDLdo7gWRNidaD5VzI6xqIRNQqKyDp4iuEwRap8uQwq3QRVfx+YAf62uRuq07bvwb88cSFlc18rR7hIABoRi6Xlw6uyf78GMQd7GORgxZM0oV3Rvx77bvuquNary+NCRqoJUW44ZuIoBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b=sMbHpLWv; arc=pass smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b="sMbHpLWv"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so477850a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 07:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776435302; cv=none;
        d=google.com; s=arc-20240605;
        b=ag6E36mLcGbDKXNSBuECUVWK+tJCAA60ERWK4qpnKGP4LnMdivUD59+EgKeVfmRilN
         hUcYuRhmIxe9cARpWLHAYE/TW4Ro+UUqRY9X1XsXd+gSk4ExbV24kqwqczYtrDOrbmIb
         AvAyanhlgY6aTLC2s8hpZxBJRO+lCdiIOfFnK5074z/n2QyQM+EkA5z4Kx1g1z0cet5V
         Vt9ZlnO5JkaEHI1c0lnXxewBzwR6bhvHZcvThmbQXjAtEfLHNM0/ubctAYBjh/YGK97R
         PQ81eC2FDSIWFlca82tZcSXeOj3DMfeUJOIFOo1rGWDmGFEMdzm77JmO3OG/aETPhvsd
         8FIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=v0LVR84ovmRud1ClQM5bdLMItwv4NwK3A85IHHZUnvw=;
        fh=5xwiCjAC8VRc+F3C6vtwo1WQT1UEY/QIdJVPfFtzBuE=;
        b=G78F5YvOzhsYfDpbyPPppqRJXGWm/mVeMGbyeVbZaEd5IfTIyAi7E/uqnfNc1YcKPS
         ZkiuWoTy+eD7BMHbXTDAv8OgglTBnl5BUwrWeysSMfzOdQrgjxJ3DNNzJyfCgVsuqEjT
         k08Un+vi58fiyQJiXRNnvdjhS6GDDeRJfxJIbY/Vn6xj2p7rv2srTdX1Ev8XmLRYyDaz
         qqJwPmrpdrW1HwDV9TAhJZaWx3fGB4wvQ7nhM3kquYtX7J7QNARSeWDAHZ5yOemxtxNM
         gxpwJ6BFIE4yDgHqgkbGwGMK7i1/DxAOn8oV6b2aGQQtbFJO1gBcWUIGrvLeRzFj09OY
         F3WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20251104.gappssmtp.com; s=20251104; t=1776435302; x=1777040102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0LVR84ovmRud1ClQM5bdLMItwv4NwK3A85IHHZUnvw=;
        b=sMbHpLWv1rwf8upaZQXqlTZKte2yT422gTdQOILpWYDgXVajKeZSllYQ1iVszCd+t3
         HsehBrlDAmSWL4mapv9iLTkQw1OOc5REKCPky3jyHAv7xRWod+bQiSS0GN3soJbEPcqH
         7o0wZzUIUOx3SNXwovfgpNj0Ix73JaJpX80eTQVKmoB1BkkWZc5MKYyNJgGRqMPiQ75W
         IvF6y+pIqIaRwvKZMDorCY75H5SRr6z17G0W5h6n5S1Cmcz1Jfb7sPyMs8XSlGzzyle9
         hvMdq2ToPuZimsfxjdZlVjr91OQH5mr5VO+KZxrtA1t6pMxSoDRlJm2x+w2YxqiSuoX0
         VDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435302; x=1777040102;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0LVR84ovmRud1ClQM5bdLMItwv4NwK3A85IHHZUnvw=;
        b=tL4EYKiNBniIKNFQCyKJCX0vLcSLpcQOAMHiteSTRdcKS6+eRv92SywT/sQsVagwCS
         upEkjmTAbwaeace8JvRmX5GdOsmTFFJvd78MOFgqQt7x/+k/3fy8gClSoS6eQ6KIgewL
         xYFKW874M1aIZqs0gpn6Rdz2CtHOXC4skv0T8bdev7UXEhdSTd+PybK5QJjy3uPxgNxQ
         H7FrUUulymJvjDoNRsaXVYptrhcRLINwW6tO77W+vZfNkLsy3lbveWtR7QQaEXvOIMjW
         wqdqx/0hhFNVrXXbmdQu39/ugUsNnF11eta1DIdEXLRzrFhM8ikXVzDLrYKvjwC9u+db
         686Q==
X-Gm-Message-State: AOJu0Ywhy1o4RAyeUFFqwgkf9uYBobfbp4j4pBXNY4n8wqlbfd7oEXXJ
	dX/YziNGBLySHrf8zfQx+LEmJxeCroCkq73tBDeyS/S4TCj5XKEUILao4F/QB15YnJGO+R2KrOO
	6U3fuoADcBbkrPenQ/v6crJ3c/bgFJcDA84M8BTgOzjwlHUdG4RtRaNy1eQyW0Q==
X-Gm-Gg: AeBDiev5iT+G/k1pO0fKOWYqsUjCXqaU1EzCN2pkiQgUMJkxa4jIauGjHqbQC7rzhGQ
	9TsFS+NmYEemzH7ve0NV0YRnbjkZu5JIUJPtDoW/JfKpaOOOM16tnvhRoUvP+uiO9+qEel8yDjU
	E3tVJ8IrhLILogyzxMFom/rxz4euo4fNJJtEn3LLR0N+wGCKalSG7y4EzY1TxkR5wXaD0MWSjt/
	K8jO2kr4i+3QfXaE/p+atv0HfcpffCZdUTp0RBoyx+UHDhlCYIBcbj1EygCaJp7u9b/JI3zDRit
	tTW77bfr8QOg+rB5zCOEF9YE/OYwGQ==
X-Received: by 2002:a17:90b:3c52:b0:35f:b50e:defc with SMTP id
 98e67ed59e1d1-36140473f07mr3313006a91.16.1776435302575; Fri, 17 Apr 2026
 07:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Fri, 17 Apr 2026 10:14:50 -0400
X-Gm-Features: AQROBzBfse2LEMfjNGrlHtwH3k7M0B-JU_LO5cCmA1IYbIZ0Pp0QZCK98MsYbM0
Message-ID: <CAOg9mSTTi0E5wgs8ZupXNa97Xb3UsG-botm0JwPE64--moMsgw@mail.gmail.com>
Subject: [GIT PULL] orangefs changes for 7.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-7.1-ofs1

for you to fetch changes up to e61bc5e4d87433c8759e7dc92bb640ef71a8970c:

     bufmap: manage as folios, V2. (2026-04-13 12:14:17 -0400)

----------------------------------------------------------------
Orangefs: changes for 7.1

Fixes:
orangefs: validate getxattr response length
orangefs_readahead: don't overflow the bufmap slot.
orangefs-debugfs.c: fix parsing problem with kernel debug keywords.

Cleanup:
debugfs: take better advantage of strscpy.

New:
bufmap: manage as folios
orangefs: add usercopy whitelist to orangefs_op_cache

----------------------------------------------------------------
HyungJung Joo (1):
      orangefs: validate getxattr response length

Mike Marshall (4):
      orangefs-debugfs.c: fix parsing problem with kernel debug keywords.
      debugfs: take better advantage of strscpy.
      orangefs_readahead: don't overflow the bufmap slot.
      bufmap: manage as folios, V2.

Ziyi Guo (1):
      orangefs: add usercopy whitelist to orangefs_op_cache

 fs/orangefs/inode.c            |  36 +++-
 fs/orangefs/orangefs-bufmap.c  | 401 ++++++++++++++++++++++++++++++++++++-----
 fs/orangefs/orangefs-cache.c   |   6 +-
 fs/orangefs/orangefs-debugfs.c |  37 ++--
 fs/orangefs/xattr.c            |   4 +
 5 files changed, 411 insertions(+), 73 deletions(-)
