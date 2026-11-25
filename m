Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646279;
	b=r8FslWlmkV8xqHUKxASc816eledpGBiycC5W3S6hPN4Lf5hCjWApgAjMhcm140IuGEH8
	 k2bESwYjU/141AK9o7nWJ8EGUCysgGJQ+wwgpyjWew5y2r61YaRRQn8mEPR0iTmT5Zfgc
	 AmD+X7ANw6dHbleZi2feDSdH7NyBdDW8qmaWGhNrkzL8GJlcMSf3fABFEBfm11NqGSmTz
	 EGrBhUH+QfIC2SYg2zU6zvho4PUYhnX8drt8jWFHXfdIm1bB2LmcJRc2mEQQM6HKH/E3n
	 KIJd1jG7gya60FbhzPS5QT1rrwW7AhRdUTlSZwqXpSCBAntlbZNJiQlErplFPDPpXXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646279;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VjKgL3sFoPldgijp6lCpDuD+mopBcsgB/ttP+1X/jCk=;
	b=H1bausfDo7nMGm/lm5+GwIg37aV3xkwASTJX1K1XeLE5Emi62c4mLYyfZq8VMp1IC8Ca
	 mrsawuzUEMXEZCEh545oUu8igd5tsqRASjSTPUNs7zbF8HfQxTEQUePajemrjIWKCJ8Y9
	 Kzo6gWK1vXDnda9ao4B34h+7+IWXlq2crHHRxONZp0/SmGwHqwORB9U+sM8xKZM2LmACe
	 b7b7Tp0UgVXQsPYC7KKOu8IoBJrfdKDXM+/CvbbpvWQRkpJ1uA0QbJs4lxvOAi9ybgtFr
	 ZbWvGK+18m4PGsXEUJT7uzUiMVItvKUvRj9HjLbxhb7eGueq+Cm6mvVWKAP1UkVeq8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Remf4O7f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5360606A31E;
	Wed, 25 Nov 2026 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Remf4O7f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144731F000F2;
	Wed, 25 Nov 2026 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646279;
	bh=VjKgL3sFoPldgijp6lCpDuD+mopBcsgB/ttP+1X/jCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Remf4O7fx/AFusGUzQGfMeurEwsxkr3JAjv+utPVTBog7uXBrh9k8Olw0S4aBBWhq
	 ZMJr8AK1bKTrctfwD5XRfVhKpDhV7RyCR8E1x1xIwcvB61Ab4cw0rGSZ70ZgC8AdR6
	 6xJLwj2ERSj36Qh6Ucu2sFyMuwQVBG0fqIBxlarS4qmcqQvdGdSDV3X7v/hqXRfNky
	 Vhfpt0qB2IOsztafgaQR2l0+2LyC0G1q9087mysc9AGjAvNdcLk3sYD0lb9D8U1Z6p
	 UrboJ+kOxmYit4FP9EApxwoNXZr+jjkmcoeRU1xVWookI9Wj69k/JrjzwYsFEXGYg5
	 zjG06Bjo1tVbQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:15 +0100
Subject: [PATCH 17/21] hugetlbfs: seal SHM_HUGETLB files against growth
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hugetlb_fixes_2-v1-17-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=david@kernel.org;
 h=from:subject:message-id; bh=7MoiVxUj4TNHB3tVg+ZjfIFB8GSvxEg3MaoP8tyv0c4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1SjvLf+tbVQYWRgEJnlsbPsrAqLUZ7mS+OLfwP/X
 0xm0k3pKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCILtBgZVgpIsu3W3CuwUPdH
 zXMxCa+e5KwHG49FdB72aCufc9ayipHhxDV7EeHYao7bdqpWu+INNpR1n3JbvdRCbeoWvSs1i3O
 5AQ==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

The size of a SysV shared memory segment is fixed at shmget(), and
do_shmat() relies on that by mapping i_size bytes of the backing file.

However, with SHM_HUGETLB, the hugetlbfs file can be grown through an
fd obtained from /proc/<pid>/map_files with ftruncate() or fallocate().
Also, remap_file_pages() with a pgoff beyond the segment can grow it,
because hugetlbfs_file_mmap() grows the file to the end of a writable
mapping:

    shmget(key, 4M, SHM_HUGETLB)            i_size = 4M
    addr = shmat(id, NULL, 0)
    remap_file_pages(addr, 2M, 0, 6M >> PAGE_SHIFT, 0)
                                            i_size = 8M
    shmat(id, NULL, 0)                      maps 8M

Later calls to shmat() will map the bigger size.

Using /proc/<pid>/map_files requires CAP_CHECKPOINT_RESTORE, but
remap_file_pages() does not require any privileges, so we focus on the
latter.

Let's fix it by setting F_SEAL_GROW on the inode when creating it for a
segment. remap_file_pages() beyond the segment still succeeds, like for
shmem segments, but accessing pages there now correctly results in
SIGBUS.

This has low urgency, and likely nobody ever ran into this in practice.
Let's not CC stable.

Fixes: c8d78c1823f4 ("mm: replace remap_file_pages() syscall with emulation")
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0b96fdc3ad9d8..f1a8208ffc818 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1559,8 +1559,11 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 				    S_IFREG | S_IRWXUGO, 0);
 	if (!inode)
 		goto out;
-	if (creat_flags == HUGETLB_SHMFS_INODE)
+	if (creat_flags == HUGETLB_SHMFS_INODE) {
 		inode->i_flags |= S_PRIVATE;
+		/* The size of a segment is fixed at shmget(). */
+		HUGETLBFS_I(inode)->seals |= F_SEAL_GROW;
+	}
 
 	inode->i_size = size;
 	clear_nlink(inode);

-- 
2.56.1

