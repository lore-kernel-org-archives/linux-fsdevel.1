Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD938D6A4;
	Thu, 12 Mar 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312351; cv=none; b=MZ0wozuJXhnKhwepoIyH4jFLqXEmcPPxx5/oR9HMh2l0L2DV93p/waxY8EMdJn06wNGujevknH0qjK0iIZmQ5oDzNDD7y55d6FJ54itPt5h5TA1kdjYmaM4Rx8ggLSpo7Ag7GCYWpNdyoNq3eRy/hmqcepXmx/TcDQui27x1Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312351; c=relaxed/simple;
	bh=O/32gCJr9nYwVGUsahUTNtCa27CVgCpogvorEO1nAVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QU9r8rQzFGIL7y347LBIIbauU2MMSVYCvkJGHHB1UoqYP1hdzLXG2fNfbQYMUJfHDc0DM39bB2u2g90OhApFdwTXycg6wOdO59CPxLUjeDvnxd0XHXfOow1FCbk8PJ9Yl9UM6/hk9xoezxiyueCdLY9sb9VkBEhuz5sdAnGSTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62CAjIIg094965;
	Thu, 12 Mar 2026 19:45:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62CAjIxs094960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 12 Mar 2026 19:45:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
Date: Thu, 12 Mar 2026 19:45:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
To: George Anthony Vernon <contact@gvernon.com>, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260311211309.27856-1-contact@gvernon.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260311211309.27856-1-contact@gvernon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

Since is_valid_catalog_record() is called before inode->i_ino is assigned,

+               pr_warn("Invalid inode with cnid %lu\n", inode->i_ino);

always prints 0.

kernel test robot <lkp@intel.com> reported that this patch needs below change.

-               if (!is_valid_catalog_record(rec->file.FlNum, rec->type))
+               if (!is_valid_catalog_record(be32_to_cpu(rec->file.FlNum), rec->type))

-               if (!is_valid_catalog_record(rec->dir.DirID, rec->type))
+               if (!is_valid_catalog_record(be32_to_cpu(rec->dir.DirID), rec->type))

Because of this endian bug, syzbot did not test is_valid_catalog_record() == false case.

This patch also needs below change.

-       if (!root_inode || is_bad_inode(root_inode))
+       if (!root_inode)
                goto bail_no_root;
+       if (is_bad_inode(root_inode)) {
+               iput(root_inode);
+               goto bail_no_root;
+       }

Since this bug is reported when "rmmod hfs" is done, syzbot would not be
able to find this bug.

And even after both changes are applied, my patch still makes sense
because mount() operation still succeeds for cnid >= 16. :-)
