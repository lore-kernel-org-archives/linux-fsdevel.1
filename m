Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793460011;
	b=zao8MOwkWDyF/vfVeXIYQZdzL7hsL/TQlf9SOjl7i2KiR8OvwahNdFYwTthgMYOQjEfp
	 AWy+ni2PjAOGAIINgtN6f0jL0yD/Io4CALANrQrW9Xq51rcdyIVtdJJ0lgmctLJpviGrh
	 Eh8HxPq78SCF2RmFVNWc3CmFZFqHTXem2kYjswu0o5RqbrmGPN3bwI5DvOgdPRVH/aNEP
	 rZiN+Ep9vIrp7O+6BRO9hai8qCPHD10RfX+R/G/3uQx1VTAFaFTOTsGqHr2uEHSTMCnbx
	 dFPkx89jtjGmBN8504upTwwevYYa2clGgPy14Sk0pKGAqpxRuRyZMWQkwldRu7sVDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460011;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=EC84ZeDwGNbU3kM7epI4jpjAY2qq946zbytyJvDGJhk=;
	b=Gfey8VWBIv2iGl1QsBv2DO8Jb0ezx/w98nOZSJYnOP+RR+1EtU+grSsv98vTY98AncQH
	 eBr25jTGEykhENbi5qkQ/Y2PZT+2gfeRPGb6iwm0Yq+MGCMICo+GdvS2wXsWgctqLy61D
	 xsy0UiWP6Z3SSP8CZk7dG9V44pvsiIInOfq84L7D24GoX3WHQ9ib4uyfKUhrfBz4MOoBN
	 qGRddDbidrxUv2Xu6s1AcgDuws74sMkZyqE+TccXDKVHQKqf4j2dvysfdRUtAB+6C68qI
	 aVuPhSkrlPEwVSN3Q8W5/FTDoapNFyOAqQoy7Fr3mTe33VeoNvtRie+/fri5os626hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeoR668K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFEC606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeoR668K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916821F00919;
	Sat, 31 Oct 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793460010;
	bh=EC84ZeDwGNbU3kM7epI4jpjAY2qq946zbytyJvDGJhk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=AeoR668KXZyZ7KW4U+Llw031xbeX9Vxpogr7TheaWfOd77ka4nb+L+dc59nesP06t
	 wFshgXYBO6sIKYdP8SlhJHa+LPVyXE1Ahb3fnYHQmaKr7vuulu0CHUaUI35tLhTccX
	 r/mUTikBd1BUePC/F1aPtuMzpGK9cNxQtTtB7cuIhTY7iIzVS1U44+FApLGAX+PuPQ
	 3uasOos9a63/f1Kv8l4PpQ0JVjqk3zvu9fdM4Iqb1raj+SjSqkracej1PlLL20hrtF
	 dwlW55N2rD21xHUYFpt852o/idWskgqFHaARjBcDJGylTA5HVT3lOQ7qkZ0WRyaeMS
	 0jMS6N+E89PpQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8356F40066;
	Sat, 31 Oct 2026 11:20:09 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 31 Oct 2026 11:20:09 -0400
X-ME-Sender: <xms:KQfmarQV6ZFKfJ0vOVk9CKhQ9dIiF7rZ8Q56HrQ5fjEBixIQGFyZOw>
    <xme:KQfmannJPH8Vb6AWVxGwD-d3yAAp9_TZyYH-fvOlM3eA8yjAujYoUj7Pto1gmErPn
    3bgYkPNMFrihJ3Q_TPKa-otk2NArVcb_Drak3d7AbM-Zg3hNvUnUA>
X-ME-Proxy-Cause: dmFkZTGzXQviQdazIoB1V+yQX9XmWXPn6uQ+aYlASCHpNc/PuqkQ45zexCsQ5tess7YInh
    gZL9uZrLAKiZV/ytyNrxZP93+NUvyTKwOZ3Si8EetggAeW+KMfMsmfz1WwLgwaPwEP1xV7
    8WFLpgtTu7gL/jNkhM8HHQ5G7cUWCo1baNpyLYiokyWuOYFr2hkKRy9LJxJuDHZlZOXPSo
    NCkeUGSIRlKsOWJ+gf91r5UHpAMPF6XBCbQ1dFK5UtqPAlouxmdDvlWB3ZQ0wkakLTYpLt
    8cLEVbWfIqLPNSf0+H7RWNU2Mi8ok0VksK3wvP3csVm8CjkfdhAPV8AK1+viqpZwCS6Bd4
    3GSaZRglCUv4lhpxoW29MyWIuL2mV8NQQBxMoK+PdP/a15QCgxExcFfT0z0B1ZiMw8u1U6
    ZK2HBiPSHc0dX+JKUlKbWYziaj+DwVNTeCxs4AvDO7z8XLtuct3fAqhQbjEtdXCXPRkJ9u
    iw/EJ9zV/jCsRKvY3S+AA3QOqt6aOUdBuTqg6dHh++eyOYrQ++9lGjsWL2mM7DJuaqx/lR
    HRSGY/KymYtZZexkz3odJ99DT20L2QAU8VsA02hEMb6Z1VqpgpzRi6Hy/NKk6h0erlSbkm
    AlQ6EGd9BSwJCKE8Gr8luOkt0X2NspCLtceoh195s6pAF2PGmkdGO52CNBeA
X-ME-Proxy: <xmx:KQfmaiKrA1xu5PSYs-bRgd4PhRDEjeRYptW7V6WozsNz-ySmHNgaHQ>
    <xmx:KQfmaq3XV0dTjtAajgq1gIflBGtKfa6C-FwM-PxMLr3fO4-iG6wy0g>
    <xmx:KQfmag4XXW29qCt7icoKC1ejd6CZKfAn3D2IKYMEt2nPOcfRE45Bug>
    <xmx:KQfmar_EjuqLir0St_KN-mDkpQeUjl7aDUYGB7PFZzv4YeHLpeJaZA>
    <xmx:KQfmavW6e5kLtdxhx0BYw8vKk7erdOG05XY5fntcKmo4NOWKeEl06YUd>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88C0B782738; Sat, 31 Oct 2026 11:20:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AIXQd_9qcN8-
Date: Sat, 31 Oct 2026 11:19:49 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Yongjian Sun" <sunyongjian1@huawei.com>,
 "Nickolai Zeldovich" <nickolai@csail.mit.edu>
Message-Id: <502f156d-8323-4dcf-b130-d010ffe7fe75@app.fastmail.com>
In-Reply-To: <20261031-trennen-fenchel-hinspiel-8d5a5688f134@brauner>
References: <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
 <05e33426-c60f-441f-a76c-46dcba1c1c35@slotpi15m67>
 <20261031-trennen-fenchel-hinspiel-8d5a5688f134@brauner>
Subject: Re: [PATCH] libfs: walk offset directories in offset order
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Oct 31, 2026, at 10:41 AM, Christian Brauner wrote:
> On Fri, Oct 30, 2026 at 12:22:19PM -0400, Chuck Lever wrote:
>> 1. Each emitted entry now costs a fresh MA_STATE and a full tree
>>    descent in offset_dir_lookup(), where the list walk was one
>>    pointer chase. Can you time an ls on a tmpfs directory with a
>>    million entries, before and after? If it is noticeable, carrying
>>    the mas across the loop is the obvious fix, though dput() and
>>    dir_emit() interleaving makes that especially fiddly.
>
> Obviously it's noticable:
>
>                          base      v1        
>   getdents64 (32k buf)   146 ms    226-235 ms
>   ls -f                  0.26 s    0.34 s    
>   ls                     0.49 s    0.57 s    
>
> The fix would be to carry the mas state. If you combine this with some
> moderate batching than this would recover nearly everything but I hate
> it.

lol


>> 2. That's true today, but Jon Flynn's RFC from yesterday proposes
>>    create and unlink with the parent locked shared. The code is
>>    fine either way: it runs under rcu_read_lock() and takes d_lock
>>    before dget_dlock(), so the walk does not depend on i_rwsem.
>>    Should the patch description say that the RCU path is what
>>    makes the walk safe, and i_rwsem is belt-and-suspenders?
>
> I don't think so? The offset tree is set up with
> mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE) and not MT_FLAGS_USE_RCU?
>
> So outside of RCU mode the maple tree modifies live nodes in place.
> A lockless reader racing a writer can see a torn node. rcu only keeps
> the dentries alive.
>
> i_rwsem has always been what makes the walk safe.
>
> I really don't think we should care about an RFC when fixing an existing
> bug. Specifically when it's rather hacky. Even if we adopated an early
> hack like that shmem would have to change for this to work as it keeps
> taking the parent exclusive for create, unlink and rename.
>
> So if tmpfs wanted that thing it would need MT_FLAGS_USE_RCU and then
> readdir needs refs again and then you get the perf regression back.
>
> So pick your poison. Future changes aren't necessarly a convincing
> argument though.

Fair. So I think I was advocating for thorough documentation of the
serialization requirements rather than coding against an RFC. That
would enable Jon and Neil to adapt accordingly when the time comes
to consider it again.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
