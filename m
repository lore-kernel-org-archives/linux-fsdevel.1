Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2313191CE;
	Thu,  2 Jul 2026 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783034955; cv=none; b=EmpMxIS3X5Np0oCq1h51jxs0PsHA2l3sO7n+Lsen2N5+w1O6bSlsD0Jr3Cw8OZPqsurbCYw9DHSwfQy6KLoAx//Lzp69wMxi0SK2AAUq2yOCTrdpYxTaCEcq3idJ5cGB0uIGiEjhmHZXyZok30j+LoC+nDPsWE6z6/eIV8D+pZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783034955; c=relaxed/simple;
	bh=xKE44Ba5t2n9dUSc0va3So80cPdAG+teKtuYWJHF+0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL5nZx7Vid29Wc71QJuB7DQhC3zzYuZ4sRSit0QhTLp/hjYarClXaHWXwqOM5TH5BXScqbtXP/d0eXamstJUZk9xvnJeY9YXTgelV/8DQfxUvVfhW3rCK/DcPv3ib9k3+Ekt+qzsklNWQfZOVkYUmHMT4P3YH9vVHL+gEU/rnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 662NSfXN044251;
	Fri, 3 Jul 2026 08:28:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 662NSfIe044240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 08:28:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <62c36a06-6b9d-48d3-bfb4-80b3ff4e8f01@I-love.SAKURA.ne.jp>
Date: Fri, 3 Jul 2026 08:28:38 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: validate catalog CNIDs before instantiating inodes
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Jori Koolstra <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp

Sashiko has some comments on this patch:
https://sashiko.dev/#/patchset/20260702183800.1119202-1-davemadmaxxx%40gmail.com

On 2026/07/03 3:38, David Maximiliano Hermitte wrote:
> hfs_cat_find_brec() first resolves a catalog thread record by CNID and
> then looks up the corresponding catalog record by parent/name. On a
> corrupted filesystem image, the second lookup may find a record whose
> CNID does not match the CNID that was requested.
> 
> Validate the catalog record found by the second lookup before returning
> it to callers. Inspect the already-found record with hfs_bnode_read(),
> not hfs_brec_read(), and reject records whose CNID is invalid for their
> record type or does not match the requested CNID.
> 
> Also validate CNIDs in hfs_read_inode() before the inode is populated,
> and propagate hfs_read_inode() errors from the resource-fork lookup path.
> For the root inode path, require the root catalog record to be a directory
> with DirID == HFS_ROOT_CNID, and drop the root inode reference if it was
> instantiated as a bad inode.
> 
> This keeps hfs_write_inode() unchanged and prevents corrupted catalog
> records from reaching the existing reserved-CNID BUG() path during
> writeback.
> 
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
> Cc: George Anthony Vernon <contact@gvernon.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> ---
>  fs/hfs/catalog.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/hfs/hfs_fs.h  | 19 +++++++++++++++++++
>  fs/hfs/inode.c   |  9 ++++++++-
>  fs/hfs/super.c   |  8 +++++++-
>  4 files changed, 81 insertions(+), 3 deletions(-)
