Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550856;
	b=m7tEPg6Ypr18cZuwqKD/Z5yCh8Em6IQ+evTE9sTEKAjAoxGIGbyuGRiMQEqWQrSKsfQ6
	 qns5aXpBafZYuDHQGmE6jlI/kXFEvP7UmS91llQjo+lJr0S3rCxf5ta9qZywIV0P3lxCp
	 oQ8AL6PrDFFWVcO90N2qkBX8z+5lvlqxxrXXrNkBz2G0RxVY1iKULrOFZ8x+3AVICSP1G
	 Eb6JW1RfyTDiJLDQ2d/Rn3oQ8J8n1gssbSFjFvc27Qd+2hQlsOWvbQMlpjYvMgnG+4ucC
	 42JFPgvSgwTBbYhxNoTL0smhuFGrkf16+XVHV2v78gs67IeKXsskLa8sQrbI8MNd+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rCx4JwOyqS9rsxABap36R0Ua8O8jA9Y8vZA8i37YtWQ=;
	b=RSXGr+28+3zwKvsMURdqHzFlLtON7GxOfH92gxSoeCRD9617RLNs8Y5DUgFxXMJ2L8Si
	 oG7N3Z0k9EVjGUF7xOoW6bMt1kNvs28ban+YBpmXTXN7dl2kYssQ/Pmz+s9jq0aVf1xG7
	 rix1MGM9uieNdCuhV672n+RHUorQ+J+s7+A2O4Wse8Xnew0riS6O3nJl36AqhyFbRMU8n
	 9uoijRZY6lm9kQ1k32RGB2sEgnFGksvHMFLlnpMX6DuFgLJ4iYa2+x5iuJ2rnzJIBUVRL
	 WPxkbSLFadcWAmyHFdHS3SF5VCVrkqL/DgjB2mrTfEDBiVcU567VrPiP/eWzzDUH1hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKyswye+;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE85606A324
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 16:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE85606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKyswye+
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so3526894eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 08:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550856; x=1794155656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rCx4JwOyqS9rsxABap36R0Ua8O8jA9Y8vZA8i37YtWQ=;
        b=mKyswye+1EaSaBzM+CAZF9eUVSt4a0mLgwPI2XcFkIkQQreuwftLqT0fCCtEJGiTVB
         zTOjwIXwOB6ODV/S0NaG8MA7ujYitp5P9Gwp2HgmnZxIIqCxU6AlzCzBSQz66E+N6Orn
         0A7ETJiSHm3li3TveRs3xIz7cKmVneOYfH9lrH6iatDwl6yI+6Wqlkm56g7JjhennhFo
         QH81+w1axCRlBfkdprQSKpYvllkMi39XJ2WpzT6Ckn/do1fFQpu0eBzK+9XBsZ52gAVB
         HcfrrE4yuQUoK+6g/b37+6apsXEEVZptTlrttLlWTgVUQ/HRnSfRofSTX5/THBgBE+4o
         O7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550856; x=1794155656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rCx4JwOyqS9rsxABap36R0Ua8O8jA9Y8vZA8i37YtWQ=;
        b=0PFVX9PHdLYUwdAzNap71ycpoqbDnEMxIPIntYQnF/K3YrO5j1K78Sn4ZsKFbynHw+
         k3sxx7N5MnQQK/iR8sRuUyXL63BI1s+T4A64JmJ1DZ5sV/oZg8KKqT4id/Jfbt0CAwQ1
         hD8cqkYS0OcrObQHrn1yg8gDlai9TOFOvVY8GaxN3XAClXcddaKW155h8LGmXnat/M1Q
         +VtjxGGc8e1XiurdobwOmrYe47YzG/D/ge45LFhteHAHZwhLV7msEMrkqNZofRNIKxzr
         zBQYO6DAwyOLpMhEQ3LyDVDTPw94XiKJOL4pJhNthnmVnz08R0rFs33aJ8i53y26ax1v
         06Wg==
X-Forwarded-Encrypted: i=1; AKwUvBzAUY1YtJSZ+Hz0fBxD10OqdoEUUctmnnAmXc5MhXHaNmIyUxAaphYf990fAvDPuG2tx05aFdhmVJenzWFq@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tv1z80H3tl9LQ9Uld5q+KW8L4QrLYZonWdGSXjY4GOvw/kjJu
	SpUceRPouGZt3/RdGEZhLohKWtcM/OCh5RDYWJ5nxXqiEdlVV2kRDzbF
X-Gm-Gg: AYBFou3W42EThm5wkeX3jXzSZwHkhhrKQP1cRwLLPAl7nX0h//BOfTYqCddmh6tuQiH
	QJJDZtvEvvhKpG+rlQr+jC31XbJiEyBsr9IdSmnkT83KzTZZgUtkIQn6kBjNvj3alnPFX2Fkk48
	vDLsXft0irgCKnJpcPhuRQSjuGvtosqty2CtgQSGMsdhWhgxtYLCpyizVq/QSfvHEWurgmklVJL
	XMoAlbrrlHNzS4sXjFM+nRn9hVaQwte7uy+HeF1VAq9NMGJmgnR2DkPHOG/v5A3MUW9Z6Rbeyo2
	ZFjMG+BBUPgPEWJGyuCnU6aq0vonJrbiEUgzwhPqm4hCP4rDuZDqT0QS/d+ojt8rs/mhIlRKEgV
	Y+5Qek8Lv0t7IWe+p1vf73ufBuwIicpO+CPEP/12/Ex8eFm23Gf9jNosl9WTrVScBOLPlgwFIuW
	dIOePv2R2h0f1PdsBNJTkjeCiQThSgCQxMOxA7GVycli4dc9mpaVJFsxH9Q8jL5HY57HX7z9gvC
	jdA4PLGZV5LuSna7/YaZyxMP1exl7IYd/S7aNzcURK6RIr/sEaF/WEym0/f4YhlwJoeFHZ2mQG6
	AkDbSok5uhDJJE8C0g+XtvzwjGo8TzTDFFFuPFwelSSO
X-Received: by 2002:a05:7300:d511:b0:36a:373f:6e29 with SMTP id 5a478bee46e88-36a423312f0mr14806370eec.13.1793550855475;
        Sun, 01 Nov 2026 08:34:15 -0800 (PST)
Received: from localhost.localdomain ([61.255.248.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm39290188eec.16.2026.11.01.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:34:14 -0800 (PST)
From: Song jeonghak <thdwjdgkr123@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Subject: Re: [PATCH] hfsplus: free failed b-tree nodes in hfs_bnode_put()
Date: Mon,  2 Nov 2026 01:29:49 +0900
Message-ID: <20261101162949.147400-1-thdwjdgkr123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <773c7445-8d4b-4d94-a995-297ecee9c879@web.de>
References: <773c7445-8d4b-4d94-a995-297ecee9c879@web.de>
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

Hi Markus,

(Resending as plain text; my previous reply was rejected by the lists
because it contained an HTML part. Sorry for the duplicate.)

> How do you think about to avoid a bit of duplicate source code?

Thanks for looking at the patch. The two branches share the
unhash/unlock/free steps, but they handle different situations:

 - HFS_BNODE_DELETED is only set by hfs_bnode_unlink(), when the node
   is removed from the tree. Its slot becomes unused, so
   hfs_bnode_put() also clears its bit in the allocation map
   (hfs_bmap_free()) and, if HFSPLUS_VOL_UNUSED_NODE_FIX is set,
   zeroes it (hfs_bnode_clear()).

 - HFS_BNODE_ERROR means the node failed to load. It is still part of
   the on-disk tree; only the in-memory copy is dropped. Its map bit
   must stay set, otherwise the allocator could hand out a node that
   is still linked, and its on-disk contents should not be
   overwritten. In my reproduction the failing node is the header
   node (node 0), which must always stay allocated. From reading the
   code, hfs_bmap_free() would hit its BUG_ON(!node->this) for it;
   I have not run that.

I looked at how other put functions that take the lock with
atomic_dec_and_lock()/refcount_dec_and_lock() deal with this, and
both forms are used. ceph_put_snap_realm() in fs/ceph/snap.c repeats
the unlock in each branch, while fsnotify_put_mark() in
fs/notify/mark.c records the difference in a flag and does the common
part once. Following the second style, the two branches could become:

		bool deleted = test_bit(HFS_BNODE_DELETED, &node->flags);

		if (deleted || test_bit(HFS_BNODE_ERROR, &node->flags)) {
			hfs_bnode_unhash(node);
			spin_unlock(&tree->hash_lock);
			if (deleted) {
				if (hfs_bnode_need_zeroout(tree))
					hfs_bnode_clear(node, 0, tree->node_size);
				hfs_bmap_free(node);
			}
			hfs_bnode_free(node);
			return;
		}
		spin_unlock(&tree->hash_lock);

I am fine with either form and will use whichever the maintainers
prefer in v2.

While looking into this I found a mistake in my changelog. It says a
failed node "has no b-tree map bit to release and no contents to zero
out". That is wrong: the bit is set and the contents are on disk. They
are left alone on purpose, as described above. I will correct this in
v2.

Regards,
Song jeonghak
