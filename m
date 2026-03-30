Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED22FD7D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894673; cv=none; b=rBXfQD4gYPzyj2xQRBykZJTIwFgBNbc4Ao83Vnk+CddcNz3TRjLTaCmWI6hb9U4quimThcgjXl3oX3YFSPbtdzr2ek3S76n9Y/1dk+FxAnwL2dK4NT4+Why0H6jKtZ+tOrgXTuutLFyxVU4emLkU6+4JAKAEYA0v5rWo3W/OcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894673; c=relaxed/simple;
	bh=2mJc5wLq8Ucu6M2B1eccgkc6LsX0ts8M984jDj/ncqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/qZhugcXsZkoG/DzPtX2ItEPSW4+Oz1eZbiZsApQ0e4T5eyeX3d+IXK96yukZlpJTtSYmwRFCcswJi8KW0YyZqGL0diNxegNdJFmRYwkPGfN1Gn2fmev0sFm5beU7k+ubMCoxLu81HNHZisZYZ8GVTRXVCqtA/EwEZsc38MdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=DIX1+4bz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="DIX1+4bz"
Date: Mon, 30 Mar 2026 19:17:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1774894658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXfGi9hlA2Z9kHi6R5YhnSyJfGi/BxFr5EY8QYh4ZUY=;
	b=DIX1+4bz7WDdVKQmBEgbOv1IADuwckphHBC3x52X7gU9GyC5wzPfpFT3zkDFnaQcFaPZFf
	KljPP+8dBC5wsXJem0C2Oo7RGbR9MbdyRDgv1AZ35K2i+BbOw4fTqcf76xCz6Cqvd0gxD6
	rkmMbNq5xRT87QSf1xODU7QlCF5gOrBuhkXcABAohAzhgnQJ96TlFNI0xVo45fCekQLkhl
	2gxlZHJHMIDQmV9s8llqi6ypSEOKRRHMUX/57LVKbsUxBVeNV6SLxQ/xKHvPNE8Zj+FGrp
	/mYrzKPu+sl62TPRTgJ4SrasCYoTpd5Gbpwh4TpaJTnHSG11lPQgKQDhpvVwCw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: Re: [PATCH v5] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <acq-PxD0rbYULr-5@Bertha>
References: <20260329205949.701267-1-contact@gvernon.com>
 <6f43ac51-aeab-4d2f-ba11-432dcf0d88f7@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ROZg4Fp1zV5tyFbM"
Content-Disposition: inline
In-Reply-To: <6f43ac51-aeab-4d2f-ba11-432dcf0d88f7@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT


--ROZg4Fp1zV5tyFbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2026 at 06:49:46PM +0900, Tetsuo Handa wrote:
> On 2026/03/30 5:59, George Anthony Vernon wrote:
> > This patch was regression tested by issuing various system calls on a
> > mounted HFS filesystem and validating that file creation, deletion,
> > reads and writes all work.
> 
> I can't believe that this patch was tested.
> Did you build a kernel with this patch applied?
>
Of course I did, just as the commit message states, using a loopback
filesystem. I missed these warnings amongst stdout noise. Thanks for
telling me, I'll take care to redirect stdout when I'm compiling.
> 
> > Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
> > I-love.SAKURA.ne.jp/T/
> 
> Please don't break, for this generates a dead link when browsing as HTML.
> 
Okay.
> 
> 
> > I have tested this with syzbot's reproducer and my own reproducer.
> 
> Can you share your reproducer, for you said that you can consistently
> reproduce that BUG() with my patch applied.
> 
Sure, it is attached to this email. It gives file1 a CNID of 13, which
with your patch isn't checked on read, but hits the BUG() on writeback.
> 
> 
> > @@ -348,6 +373,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  	struct hfs_iget_data *idata = data;
> >  	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
> >  	hfs_cat_rec *rec;
> > +	u32 cnid;
> >  
> >  	HFS_I(inode)->flags = 0;
> >  	HFS_I(inode)->rsrc_inode = NULL;
> > @@ -369,6 +395,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  	rec = idata->rec;
> >  	switch (rec->type) {
> >  	case HFS_CDR_FIL:
> > +		cnid = be32_to_cpu(rec->file.FlNum);
> > +		if (!is_valid_catalog_record(cnid, rec->type))
> > +			goto make_bad_inode;
> >  		if (!HFS_IS_RSRC(inode)) {
> >  			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
> >  					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
> > @@ -377,7 +406,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  					    rec->file.RPyLen, be16_to_cpu(rec->file.ClpSize));
> >  		}
> >  
> > -		inode->i_ino = be32_to_cpu(rec->file.FlNum);
> > +		inode->i_ino = cnid;
> >  		inode->i_mode = S_IRUGO | S_IXUGO;
> >  		if (!(rec->file.Flags & HFS_FIL_LOCK))
> >  			inode->i_mode |= S_IWUGO;
> > @@ -390,7 +419,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  		inode->i_mapping->a_ops = &hfs_aops;
> >  		break;
> >  	case HFS_CDR_DIR:
> > -		inode->i_ino = be32_to_cpu(rec->dir.DirID);
> > +		cnid = be32_to_cpu(rec->dir.DirID);
> > +		if (!is_valid_catalog_record(cnid, rec->type))
> > +			goto make_bad_inode;
> > +		inode->i_ino = cnid;
> >  		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
> >  		HFS_I(inode)->fs_blocks = 0;
> >  		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
> > @@ -399,8 +431,13 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  		inode->i_op = &hfs_dir_inode_operations;
> >  		inode->i_fop = &hfs_dir_operations;
> >  		break;
> > +make_bad_inode:
> > +		pr_warn("Invalid inode with cnid %lu\n", cnid);
> > +		pr_warn("Volume is probably corrupted, try performing fsck.\n");
> > +		fallthrough;
> >  	default:
> >  		make_bad_inode(inode);
> > +		break;
> >  	}
> >  	return 0;
> >  }
> 
> I consider that this approach is still buggy. Why do we need to call make_bad_inode()
> and preserve the inode on-memory instead of destroying the inode? Why not just return
> non-0 value instead of calling make_bad_inode() ?
> 
> hfs_read_inode() is called from inode_insert5() from iget5_locked() when
> hfs_test_inode() from find_inode() from inode_insert5() from iget5_locked() returned 0.
> 
> hfs_test_inode() tries to return 1 based on inode->i_ino, but since you are calling
> make_bad_inode() without initializing inode->i_ino, hfs_test_inode() will always
> return 0.
> 
>   static int hfs_test_inode(struct inode *inode, void *data)
>   {
>   	struct hfs_iget_data *idata = data;
>   	hfs_cat_rec *rec;
>   
>   	rec = idata->rec;
>   	switch (rec->type) {
>   	case HFS_CDR_DIR:
>   		return inode->i_ino == be32_to_cpu(rec->dir.DirID);
>   	case HFS_CDR_FIL:
>   		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
>   	default:
>   		BUG();
>   		return 1;
>   	}
>   }
> 
> As a result, a new inode is created until alloc_inode() from iget5_locked() returns
> NULL due to exhausiting all kernel memory whenever hfs_iget() is called (i.e. source
> of denial of service bug). We should not call make_bad_inode() without initializing
> inode->i_ino.
> 
> Also, I guess that we should not call make_bad_inode() from hfs_read_inode() when
> rec->type is neither HFS_CDR_FIL nor HFS_CDR_DIR, for it will accumulate the inode
> in-memory until all kernel memory is exhausited.
> 
> Again, why do we want to call make_bad_inode() instead of returning non-0 value
> (and release kernel memory) ?
> 
Let me spend some time working through this and I'll reply in another
email. :)

Thanks,

George

--ROZg4Fp1zV5tyFbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=repro.c

// https://syzkaller.appspot.com/bug?id=ee595bf9e099fff0610828e37bbbcdb7a2933f58
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 319
#endif

static unsigned long long procid;

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char *file, const char *what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

//% BEGIN CODE DERIVED FROM puff.{c,h}

#define MAXBITS 15
#define MAXLCODES 286
#define MAXDCODES 30
#define MAXCODES (MAXLCODES + MAXDCODES)
#define FIXLCODES 288

struct puff_state {
  unsigned char *out;
  unsigned long outlen;
  unsigned long outcnt;
  const unsigned char *in;
  unsigned long inlen;
  unsigned long incnt;
  int bitbuf;
  int bitcnt;
  jmp_buf env;
};
static int puff_bits(struct puff_state *s, int need) {
  long val = s->bitbuf;
  while (s->bitcnt < need) {
    if (s->incnt == s->inlen)
      longjmp(s->env, 1);
    val |= (long)(s->in[s->incnt++]) << s->bitcnt;
    s->bitcnt += 8;
  }
  s->bitbuf = (int)(val >> need);
  s->bitcnt -= need;
  return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state *s) {
  s->bitbuf = 0;
  s->bitcnt = 0;
  if (s->incnt + 4 > s->inlen)
    return 2;
  unsigned len = s->in[s->incnt++];
  len |= s->in[s->incnt++] << 8;
  if (s->in[s->incnt++] != (~len & 0xff) ||
      s->in[s->incnt++] != ((~len >> 8) & 0xff))
    return -2;
  if (s->incnt + len > s->inlen)
    return 2;
  if (s->outcnt + len > s->outlen)
    return 1;
  for (; len--; s->outcnt++, s->incnt++) {
    if (s->in[s->incnt])
      s->out[s->outcnt] = s->in[s->incnt];
  }
  return 0;
}
struct puff_huffman {
  short *count;
  short *symbol;
};
static int puff_decode(struct puff_state *s, const struct puff_huffman *h) {
  int first = 0;
  int index = 0;
  int bitbuf = s->bitbuf;
  int left = s->bitcnt;
  int code = first = index = 0;
  int len = 1;
  short *next = h->count + 1;
  while (1) {
    while (left--) {
      code |= bitbuf & 1;
      bitbuf >>= 1;
      int count = *next++;
      if (code - count < first) {
        s->bitbuf = bitbuf;
        s->bitcnt = (s->bitcnt - len) & 7;
        return h->symbol[index + (code - first)];
      }
      index += count;
      first += count;
      first <<= 1;
      code <<= 1;
      len++;
    }
    left = (MAXBITS + 1) - len;
    if (left == 0)
      break;
    if (s->incnt == s->inlen)
      longjmp(s->env, 1);
    bitbuf = s->in[s->incnt++];
    if (left > 8)
      left = 8;
  }
  return -10;
}
static int puff_construct(struct puff_huffman *h, const short *length, int n) {
  int len;
  for (len = 0; len <= MAXBITS; len++)
    h->count[len] = 0;
  int symbol;
  for (symbol = 0; symbol < n; symbol++)
    (h->count[length[symbol]])++;
  if (h->count[0] == n)
    return 0;
  int left = 1;
  for (len = 1; len <= MAXBITS; len++) {
    left <<= 1;
    left -= h->count[len];
    if (left < 0)
      return left;
  }
  short offs[MAXBITS + 1];
  offs[1] = 0;
  for (len = 1; len < MAXBITS; len++)
    offs[len + 1] = offs[len] + h->count[len];
  for (symbol = 0; symbol < n; symbol++)
    if (length[symbol] != 0)
      h->symbol[offs[length[symbol]]++] = symbol;
  return left;
}
static int puff_codes(struct puff_state *s, const struct puff_huffman *lencode,
                      const struct puff_huffman *distcode) {
  static const short lens[29] = {3,  4,  5,  6,   7,   8,   9,   10,  11, 13,
                                 15, 17, 19, 23,  27,  31,  35,  43,  51, 59,
                                 67, 83, 99, 115, 131, 163, 195, 227, 258};
  static const short lext[29] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2,
                                 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
  static const short dists[30] = {
      1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
      33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
      1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
  static const short dext[30] = {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
                                 4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
                                 9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
  int symbol;
  do {
    symbol = puff_decode(s, lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 256) {
      if (s->outcnt == s->outlen)
        return 1;
      if (symbol)
        s->out[s->outcnt] = symbol;
      s->outcnt++;
    } else if (symbol > 256) {
      symbol -= 257;
      if (symbol >= 29)
        return -10;
      int len = lens[symbol] + puff_bits(s, lext[symbol]);
      symbol = puff_decode(s, distcode);
      if (symbol < 0)
        return symbol;
      unsigned dist = dists[symbol] + puff_bits(s, dext[symbol]);
      if (dist > s->outcnt)
        return -11;
      if (s->outcnt + len > s->outlen)
        return 1;
      while (len--) {
        if (dist <= s->outcnt && s->out[s->outcnt - dist])
          s->out[s->outcnt] = s->out[s->outcnt - dist];
        s->outcnt++;
      }
    }
  } while (symbol != 256);
  return 0;
}
static int puff_fixed(struct puff_state *s) {
  static int virgin = 1;
  static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
  static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  static struct puff_huffman lencode, distcode;
  if (virgin) {
    lencode.count = lencnt;
    lencode.symbol = lensym;
    distcode.count = distcnt;
    distcode.symbol = distsym;
    short lengths[FIXLCODES];
    int symbol;
    for (symbol = 0; symbol < 144; symbol++)
      lengths[symbol] = 8;
    for (; symbol < 256; symbol++)
      lengths[symbol] = 9;
    for (; symbol < 280; symbol++)
      lengths[symbol] = 7;
    for (; symbol < FIXLCODES; symbol++)
      lengths[symbol] = 8;
    puff_construct(&lencode, lengths, FIXLCODES);
    for (symbol = 0; symbol < MAXDCODES; symbol++)
      lengths[symbol] = 5;
    puff_construct(&distcode, lengths, MAXDCODES);
    virgin = 0;
  }
  return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state *s) {
  static const short order[19] = {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
                                  11, 4,  12, 3, 13, 2, 14, 1, 15};
  int nlen = puff_bits(s, 5) + 257;
  int ndist = puff_bits(s, 5) + 1;
  int ncode = puff_bits(s, 4) + 4;
  if (nlen > MAXLCODES || ndist > MAXDCODES)
    return -3;
  short lengths[MAXCODES];
  int index;
  for (index = 0; index < ncode; index++)
    lengths[order[index]] = puff_bits(s, 3);
  for (; index < 19; index++)
    lengths[order[index]] = 0;
  short lencnt[MAXBITS + 1], lensym[MAXLCODES];
  struct puff_huffman lencode = {lencnt, lensym};
  int err = puff_construct(&lencode, lengths, 19);
  if (err != 0)
    return -4;
  index = 0;
  while (index < nlen + ndist) {
    int symbol;
    int len;
    symbol = puff_decode(s, &lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 16)
      lengths[index++] = symbol;
    else {
      len = 0;
      if (symbol == 16) {
        if (index == 0)
          return -5;
        len = lengths[index - 1];
        symbol = 3 + puff_bits(s, 2);
      } else if (symbol == 17)
        symbol = 3 + puff_bits(s, 3);
      else
        symbol = 11 + puff_bits(s, 7);
      if (index + symbol > nlen + ndist)
        return -6;
      while (symbol--)
        lengths[index++] = len;
    }
  }
  if (lengths[256] == 0)
    return -9;
  err = puff_construct(&lencode, lengths, nlen);
  if (err && (err < 0 || nlen != lencode.count[0] + lencode.count[1]))
    return -7;
  short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  struct puff_huffman distcode = {distcnt, distsym};
  err = puff_construct(&distcode, lengths + nlen, ndist);
  if (err && (err < 0 || ndist != distcode.count[0] + distcode.count[1]))
    return -8;
  return puff_codes(s, &lencode, &distcode);
}
static int puff(unsigned char *dest, unsigned long *destlen,
                const unsigned char *source, unsigned long sourcelen) {
  struct puff_state s = {
      .out = dest,
      .outlen = *destlen,
      .outcnt = 0,
      .in = source,
      .inlen = sourcelen,
      .incnt = 0,
      .bitbuf = 0,
      .bitcnt = 0,
  };
  int err;
  if (setjmp(s.env) != 0)
    err = 2;
  else {
    int last;
    do {
      last = puff_bits(&s, 1);
      int type = puff_bits(&s, 2);
      err = type == 0 ? puff_stored(&s)
                      : (type == 1 ? puff_fixed(&s)
                                   : (type == 2 ? puff_dynamic(&s) : -1));
      if (err != 0)
        break;
    } while (!last);
  }
  *destlen = s.outcnt;
  return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char *source,
                             unsigned long sourcelen, int dest_fd) {
  if (sourcelen < ZLIB_HEADER_WIDTH)
    return 0;
  source += ZLIB_HEADER_WIDTH;
  sourcelen -= ZLIB_HEADER_WIDTH;
  const unsigned long max_destlen = 132 << 20;
  void *ret = mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                   MAP_PRIVATE | MAP_ANON, -1, 0);
  if (ret == MAP_FAILED)
    return -1;
  unsigned char *dest = (unsigned char *)ret;
  unsigned long destlen = max_destlen;
  int err = puff(dest, &destlen, source, sourcelen);
  if (err) {
    munmap(dest, max_destlen);
    errno = -err;
    return -1;
  }
  if (write(dest_fd, dest, destlen) != (ssize_t)destlen) {
    munmap(dest, max_destlen);
    return -1;
  }
  return munmap(dest, max_destlen);
}

static int setup_loop_device(unsigned char *data, unsigned long size,
                             const char *loopname, int *loopfd_p) {
  int err = 0, loopfd = -1;
  int memfd = syscall(__NR_memfd_create, "syzkaller", 0);
  if (memfd == -1) {
    err = errno;
    goto error;
  }
  if (puff_zlib_to_file(data, size, memfd)) {
    err = errno;
    goto error_close_memfd;
  }
  loopfd = open(loopname, O_RDWR);
  if (loopfd == -1) {
    err = errno;
    goto error_close_memfd;
  }
  if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
    if (errno != EBUSY) {
      err = errno;
      goto error_close_loop;
    }
    ioctl(loopfd, LOOP_CLR_FD, 0);
    usleep(1000);
    if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
      err = errno;
      goto error_close_loop;
    }
  }
  close(memfd);
  *loopfd_p = loopfd;
  return 0;

error_close_loop:
  close(loopfd);
error_close_memfd:
  close(memfd);
error:
  errno = err;
  return -1;
}

static void reset_loop_device(const char *loopname) {
  int loopfd = open(loopname, O_RDWR);
  if (loopfd == -1) {
    return;
  }
  if (ioctl(loopfd, LOOP_CLR_FD, 0)) {
  }
  close(loopfd);
}

static long syz_mount_image(volatile long fsarg, volatile long dir,
                            volatile long flags, volatile long optsarg,
                            volatile long change_dir,
                            volatile unsigned long size, volatile long image) {
  unsigned char *data = (unsigned char *)image;
  int res = -1, err = 0, need_loop_device = !!size;
  char *mount_opts = (char *)optsarg;
  char *target = (char *)dir;
  char *fs = (char *)fsarg;
  char *source = NULL;
  char loopname[64];
  if (need_loop_device) {
    int loopfd;
    memset(loopname, 0, sizeof(loopname));
    snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
    if (setup_loop_device(data, size, loopname, &loopfd) == -1)
      return -1;
    close(loopfd);
    source = loopname;
  }
  mkdir(target, 0777);
  char opts[256];
  memset(opts, 0, sizeof(opts));
  strncpy(opts, mount_opts, sizeof(opts) - 32);
  res = mount(source, target, fs, flags, opts);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  res = open(target, O_RDONLY | O_DIRECTORY);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  if (change_dir) {
    res = chdir(target);
    if (res == -1) {
      err = errno;
    }
  }

error_clear_loop:
  if (need_loop_device)
    reset_loop_device(loopname);
  errno = err;
  return res;
}

static void kill_and_wait(int pid, int *status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR *dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent *ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  char buf[64];
  snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
  int loopfd = open(buf, O_RDWR);
  if (loopfd != -1) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
  }
  int pid = fork();
  if (pid < 0)
    exit(1);
  if (pid == 0) {
    setup_test();
    execute_one();
    exit(0);
  }
  int status = 0;
  uint64_t start = current_time_ms();
  for (;;) {
    sleep_ms(10);
    if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
      break;
    if (current_time_ms() - start < 5000)
      continue;
    kill_and_wait(pid, &status);
    break;
  }
}

void execute_one(void) {
  if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
  }
  memcpy((void *)0x200000000040, "hfs\000", 4);
  memcpy((void *)0x200000000080, "./file1\000", 8);
  *(uint32_t *)0x200000000100 = 0;
  *(uint16_t *)0x200000000104 = -1;
  *(uint16_t *)0x200000000106 = -1;
  memcpy(
      (void *)0x2000000009c0,
      /* file1 CNID=13; node4 valid leaf with (2,"file1") record; node2 sorted */
      "\x78\xda\xed\xdd\xcf\x6a\x13\x41\x1c\xc0\xf1\xdf\x6c\xfe\xd6\x98\x76\xb5"
      "\x15\x41\x3c\x48\x35\xe8\x49\xda\x7a\x11\x2f\x01\x09\x3e\x43\x2f\x8a\xda"
      "\x44\x28\x86\x16\x6b\x05\xf5\x62\xe8\x59\x7c\x00\xef\x5e\x7c\x00\x1f\xc2"
      "\x93\x08\x9e\xf5\xe4\xc9\x07\xe8\x2d\xce\x4e\x66\xdd\x99\x64\x37\x7f\xaa"
      "\xa9\x24\xf9\x7e\x4a\x42\xb2\x99\x99\xdd\x99\xd9\xd9\x99\xdf\x42\x1a\x11"
      "\x00\x8b\xea\x6e\xe3\xfb\x87\x5b\x3f\xa3\x87\x12\xc9\xe9\x3f\x91\x3b\x22"
      "\x41\xf4\xd1\x15\xc9\xeb\xe7\x0b\x72\xb1\xfc\x62\xef\x70\xf7\xb0\xdd\x6a"
      "\x0e\x2b\x48\xe7\x2c\x8b\x79\xe8\x82\x4c\x4e\x35\x90\x66\x67\xaf\x95\x96"
      "\x35\xca\x67\x72\x58\x61\xf4\x2e\x2f\x67\xdd\x6d\x98\x8e\xae\xf6\x83\x66"
      "\x58\x64\xe5\x64\x04\x0f\xd2\x57\x82\x92\x1d\x9d\x39\x37\xf1\x2c\x29\xf4"
      "\xbd\xef\xe8\x9a\x74\x16\xbc\xd3\xd5\xb1\x1c\xcb\x4b\x59\xe6\xf4\x07\x80"
      "\x05\x9f\x0f\x7a\xf3\x7b\x60\xe7\xf9\x8a\x5d\xbf\x07\x7a\x43\xcd\x4e\xfb"
      "\xee\xfc\xff\xad\x3a\xd3\xb5\xbd\xae\x27\x3f\xe6\x7f\x3b\xff\x9b\x28\xab"
      "\xab\xa2\xfe\x5d\x31\x1f\x25\xf1\x9e\x8a\x23\xb3\x20\x8e\x12\x27\xdd\x4f"
      "\xb4\x78\x2c\xda\x85\xa4\xb7\xc0\x54\x7e\x54\x39\x18\x2c\x9a\x63\x09\x96"
      "\x9e\xec\xb6\x5b\x37\x77\xf6\xdb\xcd\x40\x8e\xa4\x6e\x28\x37\x2e\x5c\xd3"
      "\x8f\xba\x34\x6d\xcc\x6a\x79\x47\x3b\x58\xf4\x7a\xca\x36\x5f\x51\xb2\x4a"
      "\x9b\x48\xc5\xd4\xa1\x10\xd5\x61\x2b\x39\xfe\x7a\xdd\x49\xb2\x9a\xb6\xd3"
      "\x93\xef\x71\x8c\x9e\xff\xac\xbe\xa8\x07\x2a\x94\xf7\xba\xd5\xe2\xf5\x5f"
      "\x5e\xf7\x7f\xc1\x0b\xe6\x23\xf7\x0a\xc9\xf1\x6f\x64\x15\xb7\xff\xec\xbe"
      "\x09\xda\x7b\xa9\x32\x6a\x79\xce\xec\xe4\x92\xdf\xb0\x43\x6b\x99\xcb\x8a"
      "\x48\xe2\x96\xea\xe6\xc4\xbf\x41\x10\xfa\xc7\x59\x4c\xef\xd4\x6a\x5f\xae"
      "\x5e\xed\x36\x47\x9c\x0a\xab\xa9\xb9\xb6\x46\xe4\x5a\x8b\x72\x7d\x74\x72"
      "\x25\x67\xf3\x7f\x1c\xf9\xef\xd4\xb6\x7c\x52\xdb\x6a\x5d\x1a\xf2\xcb\x09"
      "\xf4\x72\xbd\x4b\x7d\xff\xc8\x4c\x2f\xa4\xe6\x9c\x19\x43\xeb\x93\xaf\xd9"
      "\x56\x77\xe2\xaf\xcb\x92\x11\x6a\x62\xca\x92\x36\x7e\x2b\x8f\xe5\xb6\x19"
      "\xff\xd1\x36\xa5\xc7\xbf\xf2\xae\x57\x9b\x19\xdd\x51\xa5\x11\xe7\x46\x47"
      "\x96\x0f\x9e\xbf\x7a\xfd\xf4\x51\xbb\xdd\x9a\xc1\x17\xd1\x35\xd6\xdd\x22"
      "\x61\xeb\x20\x7f\x3a\x7b\x2f\xca\xdf\x96\x53\x96\x51\x69\x4a\x6e\x62\xbf"
      "\xa6\xfd\x2f\xe2\xb1\x3a\xc6\xde\xe3\x1b\x78\x23\x8f\x90\xe1\xb1\x08\x92"
      "\x4e\xcf\x4e\xf3\x86\x66\x9a\xf7\x35\x81\xea\xc5\x7f\xce\xfc\xbf\xa1\xe2"
      "\xd8\x29\x1c\xb2\x4e\xef\x8e\x5a\xb6\xf9\x2b\x8a\x81\xd8\xa0\xf4\x67\x45"
      "\x71\xc6\x29\x49\xd9\xfb\xf3\xd9\x11\x50\x25\x35\x82\xeb\x4c\x12\x73\x5d"
      "\xbd\x21\x72\x6d\xfc\x28\x2f\x94\xf3\x22\x4b\xf3\x13\xff\x37\xe4\xab\x3c"
      "\xe4\xfe\x3f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc0"
      "\xac\x39\x8d\x6f\x6b\x38\xbb\xe3\x3f\xfa\x00\x00\x00\x00\x00\x00\x00\x00"
      "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\x02\xd9\xbf\xff\x5b\x96\x29\xfe"
      "\xfe\xaf\xf7\x3d\x80\xb1\x7f\xff\xb7\x44\x7f\x01\xff\xd2\x6f\x69\xa4\x9e"
      "\xff",
      684);
  syz_mount_image(/*fs=*/0x200000000040, /*dir=*/0x200000000080,
                  /*flags=MS_NODEV|MS_DIRSYNC*/ 0x84, /*opts=*/0x200000000100,
                  /*chdir=*/0x8b, /*size=*/685, /*img=*/0x2000000009c0);
  memcpy((void *)0x200000000040, "./file1\000", 8);
  int ret = syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/0x200000000040ul,
         /*flags=O_RDWR*/ O_RDWR, /*mode=*/0);
  printf("openat returned %d\n", ret);
  if (ret == -1) {
    perror("openat failed");
  } else {
    long wret = syscall(__NR_write, ret, "x", 1);
    printf("write returned %ld\n", wret);
    if (wret == -1)
      perror("write failed");
  }
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  loop();
  return 0;
}

--ROZg4Fp1zV5tyFbM--
