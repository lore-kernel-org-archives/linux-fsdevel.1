Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257517;
	b=H9x2pynjpQId/w713RzszyuquW9riX2YtzoERVQsbgdLkF/xAiQ2+XUtDc5lt6CXJFAm
	 r+6aLhyOocRNtgfOrL0c0o+7925CbjDGFXK6emNSnrnoM7dTml1Vflqir58ibppJL8Uzx
	 KBbaDi17TZQZLxYZhXNlO1PfFMSZSZ/8gvpUZr68N1vN2WXj7wEj1PInm3XMFIbVrKndS
	 8hzsa+xSB/crZHItVtGZw/dSfI2Cmpra9OalMtvoAEj8OtR/qzQlJozXT61Jk65sPdyuT
	 hcRwSbTpQC+UqfvSu1S/F+cFG2fYo0F0nfAiKhkOzHotIAHzP3QWV2FKR5V4AFR6YBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257517;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ecPtlHM07pOhBn4SGIGMVUIyEiIcfCJ7Fc9ykw1w8nM=;
	b=i9CDssft1lobkeAuJnZ8ML845Z+kYOJHd1jgKIOFBU5Fa/iQsepmb4MUEL/OWpNr7yjc
	 DTNCepSCi7tq7wdutZ2izbvuat/3K3htDfvb6xIS9DkwyqyJm3GYshCB4rDdWxA0Ae2MA
	 pKN34iOuP+yDQNqBNQ65ga/mL68ou0n8NhhbDE1896OgP1gflN/mdm2mL7jRbJqtLsYSH
	 CSb85vKBEeGNNdTrHgxIfG3XI5nFceubpaCV+es+QE3dwqaDuBbt68ISvnVoYT7+2ydML
	 ByKUp6AnlFT1wJdCOBgq5VM4FVPiZjkzDMIPPvorJHqmJ9pshTujdoXiAtbUMS3BtIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=zwDhHCYh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LrYyUr2h;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B7606A325
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 20:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4B7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=zwDhHCYh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LrYyUr2h
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 51CBAEC01ED
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:51:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Nov 2026 15:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1794257516; x=1794343916; bh=ecPtlHM07p
	OhBn4SGIGMVUIyEiIcfCJ7Fc9ykw1w8nM=; b=zwDhHCYhstRO7bxSLOhI5RBVD9
	x+NmmmpqB71oZugKEnPpxXsj4wkQ2ToQJXfXBse0gozmVDJJa0aW6ELVHWCpQfVP
	hhGmGwo0dYPYsgUXqGWo9CLV3D7UPQDcUTmcfDh3TJyPvWrw3NG4x/DM8F5NaboD
	TPVkxhuWWdDLU5t9IpVLem8OsA/m4PgTdIJv2GoaMcgsUUG6G8ewAISMvptmkjJ8
	TXfHqinyKDJJ0sbs5ATOdDYXLyS55oF83+fe/w26dq3RjJ5HJrvY4KcIEfBjR9TI
	kd9vuT/dNnvfkHx2mL0I3mzieDXrja15iETcelTKDlvvlCQ+zf4AUvhinl5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794257516; x=1794343916; bh=ecPtlHM07pOhBn4SGIGMVUIyEiIc
	fCJ7Fc9ykw1w8nM=; b=LrYyUr2hywMGQHYc1A4CNJFdafy0yF8FyadENQjiDZoU
	+MnJnjlI+Zp2dFMyhC1k3nQKqjbiiQ85zgk67zbnV1sRh7tq+f0a+PJG9CyENTzg
	LnQjf0vmH+D5pvXgiULGYojFeCXERrNHD+pKpIMs8iUDcqSz+TtX0wY/PDrB/BCt
	+utag/KVfq8LMV+L6bl0ZJGfPN4y3UtJ2r7pwmsWg/r0mitXy+nFRqZ1++GkA6/B
	G3rKP9p+BA6HbUF3urvGI56HYRFI2AFeFhv01xlULKRDtMocsYqzquWF+O9E+U9j
	NDfTwU9+0YRlyQpKGkwR806IJoXdBVnIngu6QEFfyg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257516; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:v9T+UVzdhY6Y3gvrKmLT8CZS8hPs97JimSpre9dezqM7+fa
	U00uACttFqEfYvw05mjy5mTfeqLeUeV7I6O6WDj4JFDfvm2yvqhncD420SsJtA9i
	80Vb/p3FsKQLs43/1YbtpjOou8MZ/tHdfKnjBqmdJVzshkvZgZ6rBJ1PLq+AppLf
	QN9dsgxdFf5VnicOJ0nIvh4ZtQ/I0FBMiLiZ5sL4Bf4ALewhV/b1NjTkRMHzWKlb
	+eddsw1jrsrCTcjjthVb0bqFwu7eAOC4nFU5U1RwG9oAxohYqzWZ91i8XJU3gJaQ
	BdNpaCxETgKRQJyv/PuYD7qXE3BcFoGDUxxUTnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:m7rweaHA78wjLVhGFUdwuGQ0VZbG9xAymMMc/48bmFY=:VYJaEaDiqzzrDP5sOgaSlAS1GTZ96WcxDBmzRPWfkQw=;
X-ME-Sender: <xms:ajLyaoWSVr9Dk71fD24cbYIDY40WFDytMCzXmB2XDO4E8jPZsHA2tQ>
    <xme:ajLyaq1mlAq1BlYRZQPxPg2kMsuqWP7XpJq4zBotDeBi9khFP-znHTZlWEaxSmofT
    lozMFXl8eH9zMHT1gqmBVp0nSc5xkUm6TK6uglsOT95IvtM0A>
X-ME-Received: <xmr:ajLyaltpOXoTQXDToY67LfhmfexsxEEy8EtdB9Z9PGXmzs1fjBnkIyhWz6DhLhs8PEP4SXK0wyWeTAXcYglnDn0XryYYY9I>
X-ME-Proxy-Cause: dmFkZTEx3/BF1Z1mo1N97reZ/1MNBq/nWCMQlPDpxe2o7wy+n+ihvk6JG880YnFMgQnNaK
    10r68PzdCBuAshZqq2ekHFwQAD75zyIYHpjbYlqSy+6Ofygf0nJNe/guYUMaRoWYC2Oux3
    L8uvLX4NgeTX0hoV1DO4MhrVqpC9jZD0oWq7zBaoP68NNr0nwPc7DXIPfaCMPbB0ziVrgW
    P/Rmit6de7yBMa93rRd7U9yS8Ef/oN+bCttENzevVAC008UPg/GFJcB42tFuyqXSgbzMi1
    I2eMj4KsQrIW2T9Qjk4zJrthDF/qnf53UpyuLBwrY0cuzAQNZ3pfdO0vZFQSbxMB3aRpP2
    cQjFK4Ch+xD/JgokJeNYODBIqW+FBn3oHV8KtcJfO2fsMagKF7YTnuehi8HHOsE18m+RQL
    y2EljXs1K0BgK2Ov4HekpDXdnpUMBRNHx6kmNwW8BQy+BRcp5QHGVowcKDwP8q9h3lf26+
    VMRx5VfJFG3kjHT1dfKYvpbic0krPLgzOs5wHMRCIpvkrMrUji6eSEtXge5+up6YPOp21B
    sqhI8lpRUKUhI6/8gGQXljHY79ifAz4VJKrh0ueIU+1Suj+cZgojUkRISYn5nIPMiD5lBx
    n31AT9MftU+6R0IbdFwMjOZ9SkR08ZXzmDDiiWYE9cScVb9OZYS4lygwPAHA
X-ME-Proxy: <xmx:ajLyaqVw4p9EK1-VJ49Mc_t90YxshbAc1_F7ZWxfKu4T0oppR8Gtcg>
    <xmx:ajLyalxPhULLkhTqq2alCmCO0-tPi4kyjMtXaqVjeCeqxF6P5FVRiA>
    <xmx:ajLyahHdEMaDwagTW_tWt1Psn9bkzOxKwX2dVH7jw6xIN_bZYwdEWg>
    <xmx:ajLyaqufyM1dDyWzf8sruvHF2mDCQv5FGt9KXVFlKu6maacYhEFTOA>
    <xmx:bDLyauwcIBZi0QNQlQCrxFY3SFtgdtxUpb-GVxi7z797-D657yZoanem>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:51:51 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org,
	"Jonathan Flynn" <jonathan.flynn@hammerspace.com>
Subject: 
Date: Tue, 10 Nov 2026 07:48:22 +1100
Message-ID: <20261109205132.1561271-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
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

This v3 contains some little changes thanks to Sashiko review and Jonathan Flynn.

In 1/5 the invalidation of ->d_seq need to happen *after* DCACHE_BLOCKED
is set.  It also is not needed when DCACHE_BLOCKED is set to prevent open,
not when it is set to prevent the timestamp in ->d_fsdata from being change.

3/5 missed a dput(sdentry) in an error patch.

David: would you be able to Ack this so Christian can apply it? Or get it
headed upstream some other way?

Thanks,
NeilBrown

Original intro:

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

The requires:
 1/ the d_alloc_parallel() not be called while i_rwsem is held.  NFS does
    this in a few places. New interfaces d_alloc_trylock() and d_duplicate()
    are now available and can be used instead.  In one case we must drop
    and reclaim the lock and LOOKUP_SHARED helps with that.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  In particular d_rehash() must be phased
    out as it won't be safe. This particularly affect the mechanism to
    block lookups/revalidates while an unlink/rename is happening.
    The mechanism is changed to use one similar to how NFS addresses this
    needed, though using the new LOOKUP_PRIVATE flag.


 [PATCH v3 1/5] afs: don't unhash/rehash dentries during unlink/rename
 [PATCH v3 2/5] afs: use d_splice_alias() in afs_vnode_new_inode()
 [PATCH v3 3/5] afs: use d_alloc_trylock in afs_sillyrename()
 [PATCH v3 4/5] afs: lookup_atsys to drop and reclaim lock.
 [PATCH v3 5/5] afs: use d_duplicate()
